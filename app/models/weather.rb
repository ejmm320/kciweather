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
      @q = "lat=#{@lat}&lon=#{@lon}"
    else
      @q = "q=#{@city},#{@country}"
    end
  end

  # Here it should go first to check in Database if the weather_data exists
  # if not then goes to the API to get new info and save it.
  # API returns HTTP code as well as a Message to let the client knows about results
  def get_weather_data
    response = HTTParty.get(query_url)
    if response.code.eql?(500)
      { works: false, message: "Oops There is something wrong!!"}
    else
      obj = WeatherData.new(payload: JSON.parse(response.body))
      if obj.payload["cod"].to_i.eql?(200)
        # obj.save
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
      else
        { works: false, message: obj.payload["message"]}
      end 
    end
  end

  private

  def query_url
    "#{ENV['OWAPIURL']}?APPID=#{ENV['OWAPIKEY']}&#{q}"
  end

end
