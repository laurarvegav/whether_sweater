require 'rails_helper'
require 'active_support/all'

RSpec.describe WeatherFacade do
  before do
    @coordinates = "39.74001,-104.99202"
  end
  
  describe '.city_forecast' do
    it 'returns a forecast object with weather data for the next 5 days when date parameter is not given', :vcr do
      forecast = WeatherFacade.city_forecast(@coordinates)
      
      expect(forecast).to be_a(Forecast)
      expect(forecast.daily_weather.size).to eq(5)
    end

    it 'returns a forecast object with weather data for the next 5 days', :vcr do
      forecast = WeatherFacade.city_forecast(@coordinates)
      
      expect(forecast).to be_a(Forecast)
      expect(forecast.daily_weather.size).to eq(5)
    end
  end

  describe ".road_trip_weather returns a hash with keys" do
    before do
      roadt_params = {origin: "denver,co", destination: "broomfield,co"}
      distance = 33.minutes + 19.seconds
      @service = WeatherFacade.road_trip_weather(@coordinates, distance)
    end
    it "datetime, temperature and condition", :vcr do
      check_hash_structure(@service, :datetime, String)
      check_hash_structure(@service, :temperature, Float)
      check_hash_structure(@service, :condition, String)
    end
  end
end