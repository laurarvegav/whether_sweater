require 'rails_helper'

RSpec.describe ServicesFacade do
  before do
    @location = "Denver,CO"
  end

  describe '.city_forecast' do
    it 'returns returns a forecast object', :vcr do
      forecast = ServicesFacade.city_forecast(@location)
      expect(forecast).to be_a(Forecast)
    end
  end

  describe '#format coordinates' do
    it 'returns coordinates as taken from weather api', :vcr do
      
      expect(ServicesFacade.format_coordinates(@location)).to eq("39.74001,-104.99202")
    end
  end
end