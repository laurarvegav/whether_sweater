require 'rails_helper'

RSpec.describe LocationService do

  describe '#valid?' do
    it "returns true when valid parameter of city is given" do
      search = LocationService.new("Denver, CO")

      expect(search.valid?).to eq(true)
    end

    it "returns false when invalid parameter of city is given" do
      search = LocationService.new("Denver")

      expect(search.valid?).to eq(false)
    end
  end

  describe '#search' do
    let!(:lat_1) {"39.742043"}
    let!(:lon_1) {"-104.991531"}
    
    let(:location_search) { LocationSearch.new(query) }

    context "with city in format: City, State_abreviation" do
      let(:query) { "Denver, CO" }
      it "returns correct latitude and longitude" do
        expect(location_search.search(query)).to eq({lat: lat_1, lon: lon_1})
      end

      context "with name and city that are not valid" do
        let(:query) { {state: "Colorado", city: "San Francisco"} }
        it "returns markets matching the search parameters" do
          expect(market_search.search).to eq([])
        end
      end
    end
  end
end