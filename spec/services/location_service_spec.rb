require 'rails_helper'

RSpec.describe LocationService do

  describe '.search' do
    let!(:lat_1) {39.74001}
    let!(:lng_1) {-104.99202}

    it "returns correct latitude and longitude", :vcr do
      expect(LocationService.search("Denver,CO")).to eq({lat: lat_1, lng: lng_1})
    end
  end

  describe ".get_url" do
    let!(:uri) { "v1/address?location=denver" }
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

  describe ".connection" do
    it "successfully connects to mapquest geocoding", :vcr do
      connection = LocationService.connection
      expect(connection).to be_a(Faraday::Connection)
    end
  end
end