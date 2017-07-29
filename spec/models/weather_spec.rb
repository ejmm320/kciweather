require 'rails_helper'

RSpec.describe Weather, :type => :model do
  it "is filled with a random latitude and longitude by default" do
    weather = Weather.new
    expect(weather.lon).to be_instance_of Float
    expect(weather.lat).to be_instance_of Float
  end

  describe "#get_weather_data" do
    let(:weather_city) { Weather.new(city: 'San Cristobal', country: 've') }
    let(:random_weather) { Weather.new }

    it "returns the weather info from OpenWeather API" do
      x = ActiveSupport::HashWithIndifferentAccess.new(random_weather.get_weather_data)
      y = ActiveSupport::HashWithIndifferentAccess.new(weather_city.get_weather_data)
      expect(x[:works]).to be_truthy
      expect(y[:works]).to be_truthy
      expect(x[:weather]).not_to be_empty
      expect(y[:weather]).not_to be_empty
    end

  end
  
end