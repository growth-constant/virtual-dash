# frozen_string_literal: true

require 'rails_helper'
require 'net/http'
require 'uri'

describe 'user', type: :request do
  context 'token' do
    it 'refresh' do
      VCR.use_cassette('user/refresh_token') do
        url = URI.parse('https://www.strava.com/api/v3/oauth/token')
        https = Net::HTTP.new(url.host, url.port);
        https.use_ssl = true
        request = Net::HTTP::Post.new(url.request_uri)
        request.set_form_data({
                                'client_id' => '54154',
                                'client_secret' => 'dc5d0e5fd37d42098944c0416ebc8eb203e25488',
                                'grant_type' => 'refresh_token',
                                'refresh_token' => 'd132fa935e8293ab5c0364a6260d11bd4b6a0773'
                              })

        response = https.request(request)

        expect(JSON.parse(response.body)).to have_key('access_token')
        expect(JSON.parse(response.body)).to have_key('refresh_token')
        expect(JSON.parse(response.body)).to have_key('token_type')
      end
    end
  end

  context 'athlete' do
    it 'profile' do
      VCR.use_cassette('user/athlete_profile') do
        url = URI.parse('https://www.strava.com/api/v3/athlete')
        req = Net::HTTP.new(url.host, url.port)
        req.use_ssl = true

        headers = {
          'Authorization' => 'Bearer 603abfb153d8e19d13c56ac52fce1c1a741c98a8'
        }

        # Get the response back (he data is in the response body: resp.body )
        resp = req.get(url, headers)
        expect(JSON.parse(resp.body)['username']).to eq('csar_diaz')
      end
    end
  end

  context 'race tries' do
    let!(:victor) { FactoryBot.create(:user) }
    let!(:race) { FactoryBot.create(:race) }
    let!(:race_category) { FactoryBot.create(:race_category) }
    let!(:registration) do
      FactoryBot.create(:registration,
                        user: victor,
                        race: race,
                        race_category: race_category)
    end

    before do
      @api_endpoint = 'https://www.strava.com/api/v3'
      @segment_id = '4677383'
    end

    it 'quantity tries must be N' do
      VCR.use_cassette('race/race_tries') do
        res = Faraday.get("#{@api_endpoint}/segment_efforts",
                           { segment_id: @segment_id },
                           { 'Authorization' => "Bearer #{victor.token}" })
        expect(JSON.parse(res.body).count).to eq(30)
      end
    end

    it 'quantity tries must be N when adding start and end date' do
      VCR.use_cassette('race/race_tries_limited_by_date') do
        res = Faraday.get("#{@api_endpoint}/segment_efforts",
                           { segment_id: @segment_id,
                             start_date_local: '2020-09-16',
                             end_date_local: '2020-12-16' },
                           { 'Authorization' => "Bearer #{victor.token}" })

        expect(JSON.parse(res.body).count).to eq(21)
      end
    end
  end
end
