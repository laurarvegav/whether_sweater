class WeatherService
  def self.connection
    Faraday.new(url: "http://api.weatherapi.com/") do |faraday|
      faraday.params["key"] = Rails.application.credentials.weather["key"]
    end
  end

  def self.get_url(uri)
    response = connection.get(uri)
    
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.search(coordinates)
    data = get_url("v1/forecast.json?q=#{coordinates}&days=6")
    
    { 
      current: data[:current], 
      forecast: data[:forecast][:forecastday] 
    }
  end
end