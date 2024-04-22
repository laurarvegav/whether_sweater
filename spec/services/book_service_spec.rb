require 'rails_helper'

RSpec.describe BookService do
  describe ".connection" do
    it "successfully connects to open library api", :vcr do
      connection = BookService.connection
      expect(connection).to be_a(Faraday::Connection)
    end
  end

  describe ".get_url" do
    let!(:uri) { "search.json?q=denver,co&limit=5" }
    it "returns correct data type response", :vcr do
      data = BookService.get_url(uri)
      
      expect(data).to be_a(Hash)
    end
  end

  describe '.search' do
    book_params = {location: "denver,co", quantity: "5"}
    
    it "returns a hash with docs as key nesting an array of 5 hashes each with title, isbn and publisher keys associated to a string, array and array respectively", :vcr do
      service = BookService.search(book_params)
      expect(service).to be_a(Hash)

      check_hash_structure(service, :docs, Array)
      expect(service[:docs].size).to eq(5)

      service[:docs].each do |data| 
        check_hash_structure(data, :title, String)
        check_hash_structure(data, :isbn, Array)
        check_hash_structure(data, :publisher, Array)
      end
    end
  end
end