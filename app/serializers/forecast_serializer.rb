class ForecastSerializer
  include JSONAPI::Serializer

  attributes :current_weather,
             :daily_weather,
             :hourly_weather

  def self.format_forecast(city)
    forecast = ServicesFacade.city_forecast(city)
    {data:
    {
        id: nil,
        type: forecast.class.to_s.downcase!,
        attributes: forecast.attributes.except("id", "updated_at", "created_at")
      }
    }
  end
end