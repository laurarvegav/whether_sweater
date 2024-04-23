require 'rails_helper'

RSpec.describe RoadTrip do
  before do
    @data = {
      origin: "Cincinatti, OH",
      duration: "04:40:45",
      destination:"Chicago, IL",
      forecast: {
        datetime: "2023-04-07 23:00",
        temperature: 44.2,
        condition: "Cloudy with a chance of meatballs"
      }
    }
  end

  describe "#initialize" do
    it "exists and populates atrtibutes properly" do
      road_trip = RoadTrip.new(@data)

      expect(road_trip).to be_a(RoadTrip)
      expect(road_trip.origin).to eq(@data[:origin])
      expect(road_trip.duration).to eq(@data[:duration])
      expect(road_trip.destination).to eq(@data[:destination])
      expect(road_trip.forecast).to eq(@data[:forecast])
    end
  end
end