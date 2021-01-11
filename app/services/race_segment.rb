# frozen_string_literal: true

require 'faraday'

# Service for Race Segment
class RaceSegment
  API_ENDPOINT = 'https://www.strava.com/api/v3'

  def initialize(race, user)
    @race = race
    @segment_id = race.segment_id
    @user = user
  end

  def call
    segment
  end

  private

  def segment
    res = Faraday.get("#{API_ENDPOINT}/segments/#{@segment_id}",
                      {},
                      { 'Authorization' => "Bearer #{@user.token}" })

    if res.status == 401
      refresh_token
      res = segment
    end

    update(JSON.parse(res.body))
  end

  def update(res)
    @race.update(
      activity_type: res['activity_type'],
      name: res['name'],
      distance: res['distance'],
      average_grade: res['average_grade'],
      maximum_grade: res['maximum_grade'],
      elevation_high: res['elevation_high'],
      elevation_low: res['elevation_low'],
      start_latlng: res['start_latlng'],
      end_latlng: res['end_latlng'],
      all_data: res
    )
  end

  def refresh_token
    resp = Faraday.post('https://www.strava.com/api/v3/oauth/token') do |req|
      req.headers['Content-Type'] = 'application/json'
      req.body = { 'client_id': ENV['STRAVA_CLIENT_ID'],
                   'client_secret': ENV['STRAVA_CLIENT_SECRET'],
                   'grant_type': 'refresh_token',
                   'refresh_token': @user.refresh_token }.to_json
    end
    update_user_tokens(JSON.parse(resp.body))
  end

  def update_user_tokens(res)
    if res['access_token'] && res['refresh_token']
      @user.update(token: res['access_token'],
                   refresh_token: res['refresh_token'],
                   token_expires_at: res['expires_at'])
      true
    else
      false
    end
  end
end
