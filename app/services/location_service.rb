class LocationService
  def self.connection
    Faraday.new(url: "https://www.mapquestapi.com") do |faraday|
      faraday.params["key"] = Rails.application.credentials.mapquest["key"]
    end
  end

  def self.get_url(uri)
    response = connection.get(uri)
    
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.search(location)
    get_url("geocoding/v1/address?location=#{location}") 
  end

  def self.road_trip(from, to)
    get_url("directions/v2/route?from=#{from}&to=#{to}")
  end
end