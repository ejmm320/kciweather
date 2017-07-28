class Weather
  include ActiveModel::Model

  attr_reader :city, :country, :lat, :lon, :q

  # An empty object is a random Lat,Lon
  # if not then it should get the City and Country selected
  def initialize(params = {})
    @lat = Faker::Address.latitude.to_f
    @lon = Faker::Address.longitude.to_f
    @city = params[:city]
    @country = params[:country]
    if @city.blank? and @country.blank?      
      @q = "lat=#{@lat}&lon=#{@lon}&units=metric"
    else
      @q = "q=#{@city},#{@country}&units=metric"
    end
  end

  # Here it should go first to check in Cache if the weather_data exists
  # if not then goes to the API to get new info and save it.
  # Expires cache each 15 minutes in order to get new info from API
  def get_weather_data
    weather_data = {}
    if @city.present?
      cache_weather = $redis.get(@city)
      if cache_weather.nil?
        weather_data = get_weather_data_from_api
        $redis.set(@city, weather_data.to_json)
        $redis.expire(@city, 15.minutes.to_i)
      else
        weather_data = JSON.parse(cache_weather)
      end
    else
      weather_data = get_weather_data_from_api
    end
    weather_data
  end

  # API returns HTTP code as well as a Message to let the client knows about results
  def get_weather_data_from_api
    response = HTTParty.get(query_url)
    if response.code.eql?(500)
      { works: false, message: "Oops There is something wrong!!"}
    else
      obj = WeatherData.new(payload: JSON.parse(response.body))
      if obj.payload["cod"].to_i.eql?(200)
        #obj.save
        set_response(obj)  
      else
        { works: false, message: obj.payload["message"]}
      end 
    end
  end

  private

  def query_url
    "#{ENV['OWAPIURL']}?APPID=#{ENV['OWAPIKEY']}&#{q}"
  end

  def set_response(obj)
    { works: true,
      lon: obj.payload["coord"]["lon"],
      lat: obj.payload["coord"]["lat"],
      weather: obj.payload["weather"][0]["main"],
      desc: obj.payload["weather"][0]["description"], 
      icon: obj.payload["weather"][0]["icon"], 
      tmp: obj.payload["main"]["temp"], 
      tmp_min: obj.payload["main"]["temp_min"], 
      tmp_max: obj.payload["main"]["temp_max"],
      message: "How cool is this?" 
    }
  end

end
