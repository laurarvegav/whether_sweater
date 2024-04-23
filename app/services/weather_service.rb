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

  def self.search(coordinates, hour = "00", days = 5)
    get_url("v1/forecast.json?q=#{coordinates}&days=#{days+1}")
  end
end