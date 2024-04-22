class BookService
  def self.connection
    Faraday.new(url: "https://openlibrary.org/")
  end

  def self.get_url(uri)
    response = connection.get(uri)

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.search(data)
    get_url("search.json?q=#{data[:location]}&limit=#{data[:quantity]}")
  end
end