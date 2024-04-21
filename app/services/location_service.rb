class LocationService
  def self.connection
    Faraday.new(url: "https://www.mapquestapi.com/geocoding") do |faraday|
      faraday.params["key"] = Rails.application.credentials.mapquest["key"]
    end
  end

  def self.get_url(uri)
    response = connection.get(uri)
    
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.search(location)
    data = get_url("v1/address?location=#{location}")
    
    data[:results].first[:locations].first[:latLng] 
  end
end