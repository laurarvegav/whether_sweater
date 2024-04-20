require 'rails_helper'

RSpec.describe Forecast, type: :model do
  describe 'validations' do
    it { should validate_presence_of :current_weather }
    it { should validate_presence_of :daily_weather }
    it { should validate_presence_of :hourly_weather }
  end
  
  describe 'serializes' do
    it "current_weather , daily_weather, and hourly_weather" do
      forecast = Forecast.new( 
        current_weather: 
        { temperature: 25, conditions: 'Sunny' },
        daily_weather: { temperature_high: 30, temperature_low: 20 },
        hourly_weather: [ { time: '10:00 AM', temperature: 27 }, { time: '11:00 AM', temperature: 29 } ]
      )
      
      expect(forecast.current_weather).to be_a(Hash)
      expect(forecast.daily_weather).to be_a(Hash)
      expect(forecast.hourly_weather).to be_an(Array)
    end
  end
end
