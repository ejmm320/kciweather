class WeatherController < ApplicationController
  
  
  def new
    @weather = Weather.new
  end

  def create
    @weather = Weather.new(weather_params)
    @result = ActiveSupport::HashWithIndifferentAccess.new(@weather.get_weather_data) 
    unless @result[:works]
      render 'error'
    end
  end

  def index
    redirect_to action: 'new'
  end

  private

  def weather_params
    params.require(:weather).permit(:country, :city)
  end

end