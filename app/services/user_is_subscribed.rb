require 'faraday'

class UserIsSubscribed
  def initialize(user)
    @user = user
  end

  def call
    res = Faraday.get(
      "https://www.strava.com/api/v3/athlete",
      {},
      { 'Authorization' => "Bearer #{@user.token}" })

    if res.status === 200
      update_subscribed_user(JSON.parse(res.body))
    elsif res.status === 401
      refresh_token
      call
    else
      STDERR.puts "ERROR: Strava returned #{res.status}" 
      STDERR.puts "Response's body:"
      STDERR.puts res.body
    end
  end

  private

  def refresh_token
    res = Faraday.post('https://www.strava.com/api/v3/oauth/token') do |req|
      req.headers['Content-Type'] = 'application/json'
      req.body = { 
        'client_id': ENV['STRAVA_CLIENT_ID'],
        'client_secret': ENV['STRAVA_CLIENT_SECRET'],
        'grant_type': 'refresh_token',
        'refresh_token': @user.refresh_token 
      }.to_json
    end

    update_user_tokens(JSON.parse(res.body))
  end

  def update_subscribed_user(res)
    @user.update(
      is_subscribed: res['premium'],
    )
  end

  def update_user_tokens(res)
    if res['access_token'] && res['refresh_token']
      @user.update(
        token: res['access_token'],
        refresh_token: res['refresh_token'],
        token_expires_at: res['expires_at']
      )
    end
  end
end