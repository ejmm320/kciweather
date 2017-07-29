require 'rails_helper'

describe 'KCIWeather Spec' do
  
  # In order to show results use a Hash like this:
  # works : true if found city, false otherwise
  # weather: contains an array weather like the payload of the OpenWeather API
  
  describe 'GET weather info from OpenWeather API' do
    let(:random_weather){ Weather.new }
    let(:city_weather){ Weather.new(city: 'Barinas', country: 've') }
    let(:wrong_city) { Weather.new(city: 'XXXXXXX', country: '22') }

    context 'with valid params' do
      it 'should return the weather using a random latitude and longitude' do
        response = HTTParty.get(random_weather.query_url)
        expect(response.code).to be 200
        expect(JSON.parse(response.body)).not_to be_empty
      end

      it 'should return the weather from a given city and country' do
        response = HTTParty.get(city_weather.query_url)
        expect(response.code).to be 200
        expect(JSON.parse(response.body)['name']).to eq("Barinas")
      end
    end

    context 'with invalid params' do
      it 'should return an error with a wrong city info' do
        response = HTTParty.get(wrong_city.query_url)
        expect(response.code).to be 404
        expect(JSON.parse(response.body)['cod']).to eq("404")
      end
    end


  end
  
end
