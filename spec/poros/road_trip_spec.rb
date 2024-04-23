require 'rails_helper'

RSpec.describe RoadTrip do
  describe 'instance methods' do
    before do
    @roadt_data = {
      "origin": "Cincinatti,OH",
      "destination": "Chicago,IL",
      "api_key": @user_1.api_key
    }

    @bad_roadt_data_0 = {
      "origin": "Cincinatti,OH",
      "destination": "Chicago,IL",
      "api_key": ""
    }

    @bad_roadt_data_1 = {
      "origin": "",
      "destination": "Chicago,IL",
      "api_key": @user_1.api_key
    }

    @bad_roadt_data_2 = {
      "origin": "Cincinatti,OH",
      "destination": "",
      "api_key": @user_1.api_key
    }

    @bad_roadt_data_3 = {
      "origin": "New York, NY",
      "destination": "London, UK",
      "api_key": @user_1.api_key
    }
    end

    describe "#initialize" do
      it "exists and populates attributes correctly" do
        road_trip = RoadTrip.new(@roadt_data)

        expect(road_trip).to be_a(RoadTrip)
        expect(road_trip.start_city).to eq("Cincinatti,OH")
        expect(road_trip.end_city).to eq("Chicago, IL")
      end
    end
  end
end