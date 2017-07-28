require 'rails_helper'

describe 'KCIWeather Spec' do
  
  # In order to show results use a Hash like this:
  # works : true if found city, false otherwise
  # weather: contains an array weather like the payload of the OpenWeather API
  
  describe 'GET weather info with random geographic coordinates' do
    it 'should return the weather using a fake latitude and longitude' do
      x = Weather.new(city: '', country: '').get_weather_data
      expect(x).to be_a Hash
      expect(x[:works]).to be true
      expect(x[:weather]).not_to be_empty
    end
  end
  
  describe 'GET weather info given the City and Country' do 
    context 'with invalid params' do
      it 'should be a Hash with a key named :works and be false' do
        x = Weather.new(city: "XXXXX", country: "22").get_weather_data
        expect(x).to be_a Hash
        expect(x[:works]).to be false
      end
    end

    context 'with valid params' do
      it 'should have the weather data of the city' do
        x = Weather.new(city: "San Cristobal", country: "ve").get_weather_data
        expect(x).to be_a Hash
        expect(x[:works]).to be true
        expect(x[:weather]).not_to be_empty
      end
    end
  end
end
