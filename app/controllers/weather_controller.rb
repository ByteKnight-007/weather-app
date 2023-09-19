class WeatherController < ApplicationController
  def index
    @city = params[:city]
    
    if @city.present?
      @weather_data = WeatherClient.get_weather(@city)
      
      if @weather_data['cod'] == 200
        @temperature = @weather_data['main']['temp']
        @description = @weather_data['weather'][0]['description']
        @humidity = @weather_data['main']['humidity']
        @pressure = @weather_data['main']['pressure']
        @wind_speed = @weather_data['wind']['speed']
        @visibility = @weather_data['visibility']
        @sunrise_time = Time.at(@weather_data['sys']['sunrise'])
        @sunset_time = Time.at(@weather_data['sys']['sunset'])
      else
        flash.now[:alert] = 'City not found. Please enter a valid city name.'
      end
    end
  end
end
