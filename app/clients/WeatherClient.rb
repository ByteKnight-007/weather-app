require 'net/http'

class WeatherClient
  API_KEY = '4a17f161163f42b6ebad4b7db902dd9a'
  
  def self.get_weather(city)
    uri = URI("https://api.openweathermap.org/data/2.5/weather?q=#{city}&appid=#{API_KEY}")
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end
end