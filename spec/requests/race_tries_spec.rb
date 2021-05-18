# frozen_string_literal: true

require 'rails_helper'
require 'net/http'
require 'uri'

describe 'race tries', type: :request do
  context 'segment' do
    it 'collects them from Strava' do
      VCR.use_cassette('race_tries/get_segments') do
        url = URI.parse('https://www.strava.com/api/v3/segment_efforts')
        https = Net::HTTP.new(url.host, url.port)
        https.use_ssl = true
        request = Net::HTTP::Get.new(url.request_uri)
        request["Authorization"] = "Bearer X"
        params = {
          :segment_id => 'X',
          :start_date_local => 'X',
          :end_date_local => 'X',
          :per_page => 50
        }
        url.query = URI.encode_www_form(params)

        response = https.request(request)
        body = JSON.parse(response.body)

        # "Check the job only extract within race period (start and end dates)"
        expect(body).to have_key('start_date_local')
        expect(body).to have_key('end_date_local')

        #q check the job performs the least amount of API calls possible
        # check the job runs on time with sidekiq
      end
    end
  end
end