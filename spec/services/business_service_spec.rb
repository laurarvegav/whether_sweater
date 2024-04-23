require 'rails_helper'

RSpec.describe BusinessService do
  describe ".connection" do
    it "successfully connects to yelp api", :vcr do
      connection = BusinessService.connection
      expect(connection).to be_a(Faraday::Connection)
    end
  end

  describe ".get_url" do
    let!(:uri) { "v3/businesses/search?location=denver&categories=italian&limit=1" }
    it "returns correct data type response", :vcr do
      data = BusinessService.get_url(uri)
      
      expect(data).to be_a(Hash)
    end
  end

  describe '.search' do
    business_params = {destination: "pueblo,co", food:"italian"}
    
    it "returns a hash with business as key nesting an array of 1 hash with name, rating, display_address and review_count keys associated to a string, float, string and integer respectively", :vcr do
      service = BusinessService.search(business_params)
      expect(service).to be_a(Hash)

      check_hash_structure(service, :businesses, Array)
      expect(service[:businesses].size).to eq(1)

      service[:businesses].each do |data| 
        check_hash_structure(data, :name, String)
        check_hash_structure(data, :review_count, Integer)
        check_hash_structure(data[:location], :display_address, Array)
        check_hash_structure(data, :rating, Float)
      end
    end
  end
end