class ServicesFacade
  def self.city_forecast(city)
    response = WeatherService.search(format_coordinates(city))
    forecast_data = parse_response(response)
    create_forecast_objects(forecast_data)
  end

  private
  def self.format_coordinates(city)
    coordinates = LocationService.search(city)

    coordinates.values.join(',')
  end
  
  def self.parse_response(response)
    {
    current_weather: parse_current(response[:current]),

    daily_weather:  
      response[:forecast].map do |daily_input|
        parse_daily(daily_input)
      end,

    hourly_weather: 
      response[:forecast][0][:hour].map do |hourly_input|
        parse_hourly(hourly_input)
      end
    }
  end

  def self.parse_current(input_current)
    current_weather_data = {
      last_updated: DateTime.parse(input_current[:last_updated]),
      temperature: input_current[:temp_f],
      feels_like: input_current[:feelslike_f],
      humidity: input_current[:humidity],
      uvi: input_current[:uv],
      visibility: input_current[:vis_miles],
      condition: input_current[:condition][:text],
      icon: input_current[:condition][:icon],
    }
  end

  def self.parse_daily(daily_input)
    {
      date: DateTime.parse(daily_input[:date]),
      sunrise: daily_input[:astro][:sunrise],
      sunset: daily_input[:astro][:sunset],
      max_temp: daily_input[:day][:maxtemp_f],
      min_temp: daily_input[:day][:mintemp_f],
      condition: daily_input[:day][:condition][:text],
      icon: daily_input[:day][:condition][:icon]
    }
  end

  def self.parse_hourly(hourly_input)
    {
      time: Time.parse(hourly_input[:time]).strftime("%H:%M"),
      temperature: hourly_input[:temp_f],
      conditions: hourly_input[:condition][:text],
      icon: hourly_input[:condition][:icon]
    }
  end

  def self.create_forecast_objects(data)
    Forecast.new(
      current_weather: data[:current_weather],
      daily_weather: data[:daily_weather].drop(1),
      hourly_weather: data[:hourly_weather]
    )
  end
end