# frozen_string_literal: true

require 'faraday'

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
      segment_efforts(user, registrations)
    end
  end

  def segment_efforts(user, registrations)
    registrations&.each do |registration|
      segment_id = registration.race.segment_id
      res = segment(segment_id, user, registration.race)

      JSON.parse(res.body).each do |try|
        next if RaceTry.exists?(user_id: user.id, segment_id: segment_id, start: try['start_date_local'])

        add_race_try(user, registration, try)
      end
    end
  end

  def add_race_try(user, registration, try)
    RaceTry.create(user_id: user.id,
                   registration_id: registration.id,
                   segment_id: try['segment']['id'],
                   duration: try['elapsed_time'],
                   start: try['start_date'])
  end

  def segment(segment_id, user, race)
    # segment_id=4677383&start_date_local=2020-11-01&end_date_local=2020-11-30
    # if last try is nil we can use the date of starting race
    last_try = RaceTry.where(user_id: user.id, segment_id: segment_id).last

    res = Faraday.get("#{API_ENDPOINT}/segment_efforts",
                      { segment_id: segment_id,
                        start_date_local: last_try || race&.startdate&.strftime('%F'),
                        end_date_local: race&.enddate&.strftime('%F'),
                        per_page: 50 },
                      { 'Authorization' => "Bearer #{user.token}" })
    if res.status == 401
      refresh_token(user)
      res = segment(segment_id, user.reload)
    end
    res
  end

  def refresh_token(user)
    resp = Faraday.post('https://www.strava.com/api/v3/oauth/token') do |req|
      req.headers['Content-Type'] = 'application/json'
      req.body = { 'client_id': ENV['CLIENT_ID'],
                   'client_secret': ENV['CLIENT_SECRET'],
                   'grant_type': 'refresh_token',
                   'refresh_token': user.refresh_token }.to_json
    end
    update_user_tokens(user,
                       JSON.parse(resp.body))
  end

  def update_user_tokens(user, res)
    if res['access_token'] && res['refresh_token']
      user.update(token: res['access_token'],
                  refresh_token: res['refresh_token'],
                  token_expires_at: res['expires_at'])
      true
    else
      false
    end
  end
end
