class WeatherController < ApplicationController
  def show
    @city = params[:city]

    if @city.present?
      @weather_data = WeatherClient.get_weather(@city)

      if @weather_data['cod'] == 200
        # Convert temperature from Fahrenheit to Celsius
        @temperature = (@weather_data['main']['temp'] - 273.15).round(2)

        @description = @weather_data['weather'][0]['description']
        @humidity = @weather_data['main']['humidity']
        
        # Convert pressure from hPa to atm
        @pressure = (@weather_data['main']['pressure'] * 0.00098692326671601).round(2)
        @wind_speed = @weather_data['wind']['speed']

        # Convert visibility from meters to kilometers
        @visibility = (@weather_data['visibility'] / 1000).round(2)

        # Format sunrise and sunset times to AM/PM
        sunrise_timestamp = Time.at(@weather_data['sys']['sunrise'])
        sunset_timestamp = Time.at(@weather_data['sys']['sunset'])
        @sunrise_time = sunrise_timestamp.strftime('%I:%M %p')
        @sunset_time = sunset_timestamp.strftime('%I:%M %p')

        @weather_icon = @weather_data['weather'][0]['icon']
        @clouds = @weather_data['clouds']['all']

        # Convert feels like, temp min, and temp max from Fahrenheit to Celsius
        @feels_like = (@weather_data['main']['feels_like'] - 273.15).round(2)
        @temp_min = (@weather_data['main']['temp_min'] - 273.15).round(2)
        @temp_max = (@weather_data['main']['temp_max'] - 273.15).round(2)
      else
        flash.now[:alert] = 'City not found. Please enter a valid city name.'
      end
    end
  end
end

