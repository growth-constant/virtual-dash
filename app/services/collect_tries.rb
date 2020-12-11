# frozen_string_literal: true

require 'oj'
require 'faraday'
require 'net/http'
require 'uri'

# Service for Collect Tries
class CollectTries
  API_ENDPOINT = 'https://www.strava.com/api/v3'

  def initialize
    @users = User.all
  end

  def call
    tries
  end

  private

  def tries
    @users.each do |user|
      next unless Registration.exists?(user_id: user.id)

      registrations = Registration.where(user_id: user.id, status: true)
      segment_effort(user, registrations)
    end
  end

  def segment_effort(user, registrations)
    url = "#{API_ENDPOINT}/segment_efforts"

    registrations&.each do |registration|
      segment_id = registration.race.segment_id
      res = Faraday.get(url,
                        { segment_id: segment_id },
                        { 'Authorization' => "Bearer #{user.token}" })

      if res.status == 401
        refresh_token(user)
        user.reload
        res = Faraday.get(url,
                          { segment_id: segment_id },
                          { 'Authorization' => "Bearer #{user.token}" })
      end

      JSON.parse(res.body).each do |try|
        RaceTry.create(user_id: user.id,
                       registration_id: registration.id,
                       segment_id: segment_id,
                       duration: try['elapsed_time'],
                       start: try['start_date_local']
                      )
      end
    end
  end

  def refresh_token(user)
    url = URI.parse('https://www.strava.com/api/v3/oauth/token')
    https = Net::HTTP.new(url.host, url.port);
    https.use_ssl = true
    request = Net::HTTP::Post.new(url.request_uri)
    request.set_form_data({
                            'client_id' => ENV['CLIENT_ID'],
                            'client_secret' => ENV['CLIENT_SECRET'],
                            'grant_type' => 'refresh_token',
                            'refresh_token' => user.refresh_token
                          })
    res = JSON.parse(https.request(request).body)

    if res['access_token']
      user.update(token: res['access_token'],
                  refresh_token: res['refresh_token'],
                  token_expires_at: res['expires_at'])
      true
    else
      false
    end
  end
end
