class BusinessService
  def self.connection
    Faraday.new(url: "https://api.yelp.com") do |faraday|
      faraday.headers["Authorization"] = Rails.application.credentials.yelp["key"]
    end
  end

  def self.get_url(uri)
    response = connection.get(uri)
    
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.search(data)
    data = get_url("v3/businesses/search?location=#{data[:destination]}&categories=#{data[:food]}&limit=1")
  end
end