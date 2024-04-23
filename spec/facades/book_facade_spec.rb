require 'rails_helper'

RSpec.describe BookFacade do
  describe '.find_books retuns a hash with key' do
    before do
      book_params = {location: "denver,co", quantity: "5"}
      @service = BookFacade.find_books(book_params)
    end

    it "destination associated to a string", :vcr do
      expect(@service[:destination]).to be_a(String)
    end

    it "forecast associated to a hash with summary and temperature associated to strings", :vcr do
      expect(@service[:forecast]).to be_a(Hash)
      check_hash_structure(@service[:forecast], :summary, String)
      check_hash_structure(@service[:forecast], :temperature, String)
    end

    it "total books found associated to an integer", :vcr do
      expect(@service[:total_books_found]).to be_a(Integer)
    end

    it "books associated to a collection of book objects with title related to location in the requested quantity", :vcr do
      expect(@service[:books]).to be_an(Array)

      @service[:books].each { |book| expect(book).to be_a(Book) }
    end
  end
end