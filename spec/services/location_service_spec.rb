require 'rails_helper'

RSpec.describe LocationService do
  
  describe ".connection" do
    it "successfully connects to mapquest geocoding", :vcr do
      connection = LocationService.connection
      expect(connection).to be_a(Faraday::Connection)
    end
  end
  
  describe ".get_url" do
    let!(:uri) { "geocoding/v1/address?location=denver" }
    it "returns correct response", :vcr do
      data = LocationService.get_url(uri)
      
      expect(data).to be_a(Hash)
      data[:results].each do |result|
        
        expect(result).to be_a(Hash)
        result[:locations].each do |location|
          expect(location).to be_a(Hash)
          expect(location[:latLng]).to be_a(Hash)
          expect(location[:latLng]).to have_key(:lat)
          expect(location[:latLng]).to have_key(:lng)
        end
      end
    end 
  end

  describe '.search' do
    let!(:lat_1) {39.74001}
    let!(:lng_1) {-104.99202}

    it "returns correct latitude and longitude", :vcr do
      data = LocationService.search("Denver,CO")
      coordinates = data[:results][0][:locations][0][:latLng]
      expect(coordinates).to eq({lat: lat_1, lng: lng_1})
    end
  end


  describe '.road_trip' do
    it "returns correct formatted time as the correct string", :vcr do
      data = LocationService.road_trip("New York, NY", "Denver, CO")

      check_hash_structure(data, :route, Hash)
      expect(data[:route][:formattedTime]).to eq("24:51:19")
    end
  end
end