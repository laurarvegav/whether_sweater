class BookFacade
  def self.find_books(book_params)
    book_response = BookService.search(book_params)
    {
      destination: book_params[:location],
      forecast: book_forecast(book_params[:location]),
      total_books_found: book_response[:numFound],
      books: book_response[:docs].map { |data| Book.new(data.slice(:isbn, :title, :publisher)) }
    }
  end

  def self.book_forecast(city)
    current_forecast = WeatherFacade.city_forecast(city).current_weather
    {
      summary: current_forecast[:condition],
      temperature: "#{current_forecast["temperature"]} F"
    }
  end
end