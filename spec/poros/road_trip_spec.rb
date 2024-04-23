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

    @forecast_data = {
      last_updated: "2023-04-07 23:00",
      temperature: 44.2,
      condition: "Cloudy with a chance of meatballs"
    }
    
    @road_trip = RoadTrip.new(@data)
  end

  describe "#initialize" do
    it "exists and populates atrtibutes properly" do

      expect(@road_trip).to be_a(RoadTrip)
      expect(@road_trip.origin).to eq(@data[:origin])
      expect(@road_trip.duration).to eq(@data[:duration])
      expect(@road_trip.destination).to eq(@data[:destination])
      
    end
  end

  describe "#weather_at_eta" do
    it "formats the current weather forecast received as parameter" do
      weather_at_eta = @road_trip.weather_at_eta(@forecast_data)
      
      expect(weather_at_eta).to eq(@data[:forecast])
    end
  end
end