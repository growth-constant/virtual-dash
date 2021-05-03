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

      registrations = Registration.where(user_id: user.id, status: 'registered')
      segment_efforts(user, registrations)
    end
  end

  def segment_efforts(user, registrations)
    registrations&.each do |registration|
      segment_id = registration.race.segment_id
      res = segment(segment_id, user, registration.race)
      race_tries_for_user = RaceTry.user_segments(user, segment_id).pluck(:race_try_id)
      
      # puts "### Race name"
      # puts registration.race.title
      # puts "### Segment Efforts Res"
      # puts res.body

      # Hacer algo para cuando regrese un arreglo vacío

      JSON.parse(res.body).each do |try|
        puts "###### ENTRO AL LOOP ######"
        # puts "### Segment efforts try"
        # puts try[0]['id'].class
        next if race_tries_for_user.include? try['id']

        add_race_try(user, registration, try, registration.race.id)
      end
    end
  end

  def add_race_try(user, registration, try, race_id)
    RaceTry.create(user_id: user.id,
                   registration_id: registration.id,
                   segment_id: try['segment']['id'],
                   duration: try['elapsed_time'],
                   start: try['start_date'],
                   moving_time: try['moving_time'],
                   start_date_local: try['start_date_local'],
                   race_try_id: try['id'],
                   race_id: race_id)
  end

  def segment(segment_id, user, race)
    # segment_id=4677383&start_date_local=2020-11-01&end_date_local=2020-11-30
    # if last try is nil we can use the date of starting race
    last_try = RaceTry.last_try(user, segment_id).last

    start_date_local = last_try&.start&.strftime('%F') ? last_try&.start&.strftime('%F') : race&.startdate&.strftime('%F')
    if start_date_local.nil?
      puts "### Resta de fechas"
      puts race.created_at - 1.day
      start_date_local = race&.created_at&.strftime('%F')
    end

    res = Faraday.get("#{API_ENDPOINT}/segment_efforts",
      { segment_id: segment_id,
        start_date_local: start_date_local,
        end_date_local: race&.enddate&.strftime('%F'),
        per_page: 50 },
        { 'Authorization' => "Bearer #{user.token}" })

        if res.status == 401
          refresh_token(user)
          res = segment(segment_id, user.reload, race)
        end
        res
  end

  def refresh_token(user)
    resp = Faraday.post('https://www.strava.com/api/v3/oauth/token') do |req|
      req.headers['Content-Type'] = 'application/json'
      req.body = { 'client_id': ENV['STRAVA_CLIENT_ID'],
                   'client_secret': ENV['STRAVA_CLIENT_SECRET'],
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
