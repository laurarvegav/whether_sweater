require 'rails_helper'

RSpec.describe "Book Search Controller returns" do
  describe 'GET #book-search' do    
    before do
      get "/api/v1/book-search?location=denver,co&quantity=5"
      expect(response.status).to eq(200)

      @response_data = JSON.parse(response.body, symbolize_names: true)

      @response_attributes = @response_data[:data][:attributes]
    end
    
    describe "nested in a data hash" do
      it "correct format" do
        check_hash_structure(@response_data, :data, Hash)
        check_hash_structure(@response_data[:data], :id, String)
        check_hash_structure(@response_data[:data], :attributes, Hash)
      end
      it "id key with null value" do
        expect(@response_data[:id]).to be_null
      end
      describe "within attributes key" do
        it 'the destination city', :vcr do
          check_hash_structure(@response_attributes,:destination, String)
        end 
        
        it "the forecast in that city right now", :vcr do
          check_hash_structure(@response_attributes,:forecast, Hash)
          check_hash_structure(@response_attributes[:forecast], [:summary], String)
          check_hash_structure(@response_attributes[:forecast], [:temperature], String)
          expect(@response_attributes[:forecast][:temperature].include?(" F")).to eq(true)
        end
    
        it "returns the total number of search results found", :vcr do
          check_hash_structure(@response_attributes,:total_books_found, Integer)
        end
    
        it "a collection of 5 books about the destination city" do
          check_hash_structure(@response_attributes,:books, Array)
          expect(@response_attributes[:books].size).to eq(5)
          @response_attributes[:books].each { |book|
            check_hash_structure(book, :isbn, Array)
            check_hash_structure(book, :title, String)
            check_hash_structure(book, :publisher, Array)
          }
        end
      end
    end
  end
end