require 'rails_helper'

RSpec.describe WeatherFacade do
  before do
    @location = "Denver,CO"
  end
  
  describe '.city_forecast' do
    it 'returns a forecast object with weather data for the next 5 days', :vcr do
      forecast = WeatherFacade.city_forecast(@location)
      
      expect(forecast).to be_a(Forecast)
      expect(forecast.daily_weather.size).to eq(5)
    end
  end

  describe ".road_trip_weather returns a hash with keys" do
    before do
      roadt_params = {origin: "denver,co", destination: "broomfield,co"}

      road_trip = RoadTrip.new(roadt_params)
      @service = WeatherFacade.road_trip_weather(road_trip)
    end
    it "datetime, temperature and condition" do
      check_hash_structure(@service, :weather_at_eta, Hash)
      check_hash_structure(@service[:weather_at_eta], :datetime, String)
      check_hash_structure(@service[:weather_at_eta], :temperature, Integer)
      check_hash_structure(@service[:weather_at_eta], :condition, String)
    end
  end
end