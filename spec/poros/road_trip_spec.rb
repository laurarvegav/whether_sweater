require 'rails_helper'

RSpec.describe RoadTrip do
  describe 'instance methods' do
    before do
      @user_1 = User.create!({
        email: "person3@woohoo.com",
        password: "abc123",
        password_confirmation: "abc123"
      })

      @roadt_data = {
        "origin": "Cincinatti,OH",
        "destination": "Chicago,IL",
        "api_key": @user_1.api_key
      }
    end

    describe "#initialize" do
      it "exists and populates attributes correctly" do
        road_trip = RoadTrip.new(@roadt_data)

        expect(road_trip).to be_a(RoadTrip)
        expect(road_trip.start_city).to eq("Cincinatti,OH")
        expect(road_trip.end_city).to eq("Chicago,IL")
      end
    end
  end
end