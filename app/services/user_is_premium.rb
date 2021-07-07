require 'faraday'

class UserIsPremium
  def initialize(user)
    @user = user
  end

  def call
    is_user_premium
  end

  def is_user_premium
    res = Faraday.get(
      "https://www.strava.com/api/v3/athlete",
      {},
      { 'Authorization' => "Bearer #{@user.token}" })

    if res.status === 200
      p 'Success'
      p res.body
    elsif res.status === 401
      refresh_token
      is_user_premium
    else
      STDERR.puts res # Prints the response as an error
    end
    
  end

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

    body = JSON.parse(res.body)
    if body['access_token'] && body['refresh_token']
      @user.update(
        token: body['access_token'],
        refresh_token: body['refresh_token'],
        token_expires_at: body['expires_at']
      )
    end
  end

  def update_premium_user
    
  end

  def update_user_tokens
  end
end