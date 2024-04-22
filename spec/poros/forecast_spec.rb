require 'rails_helper'

RSpec.describe Forecast do
  describe 'Initialize' do
    it "exists and populates attribures corerctly" do
      forecast = Forecast.new( 
        current_weather: 
        { temperature: 25, conditions: 'Sunny' },
        daily_weather: [{ temperature_high: 30, temperature_low: 20 }, { temperature_high: 12, temperature_low: 10 }],
        hourly_weather: [ { time: '10:00 AM', temperature: 27 }, { time: '11:00 AM', temperature: 29 } ]
      )
      
      expect(forecast).to be_a(Forecast)
      expect(forecast.current_weather).to be_a(Hash)
      expect(forecast.daily_weather).to be_an(Array)
      expect(forecast.daily_weather.all? { |daily| daily.is_a?(Hash)}).to be(true)
      expect(forecast.hourly_weather).to be_an(Array)
      expect(forecast.hourly_weather.all? { |hourly| hourly.is_a?(Hash)}).to be(true)
    end
  end
end
