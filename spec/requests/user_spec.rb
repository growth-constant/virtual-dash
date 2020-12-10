# frozen_string_literal: true

require 'rails_helper'

describe 'user', type: :request do
  context 'user' do
    it 'shows your profile info' do
      VCR.use_cassette('example') do

        url = URI.parse('https://www.strava.com/api/v3/athlete')
        req = Net::HTTP.new(url.host, url.port)
        req.use_ssl = true

        headers = {
          'Authorization' => "Bearer ddf5727edb448ba95708ec9502daef0425fd78e5"
        }

        # Get the response back (he data is in the response body: resp.body )
        resp = req.get(url, headers)

        puts "Response: #{resp.body}"
      end
    end
  end
end
