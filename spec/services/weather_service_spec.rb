require 'rails_helper'

RSpec.describe WeatherService do
  describe ".connection" do
    it "successfully connects to weather api", :vcr do
      connection = WeatherService.connection
      expect(connection).to be_a(Faraday::Connection)
    end
  end

  describe ".get_url" do
    let!(:uri) { "v1/forecast.json?q=39.74001,-104.99202&days=5" }
    it "returns correct response", :vcr do
      data = WeatherService.get_url(uri)
      
      expect(data).to be_a(Hash)
    end
  end

  describe '.search' do
    coordinates = "39.74001,-104.99202"
    
    it "returns a hash with current key associated to a hash", :vcr do
      service = WeatherService.search(coordinates)
      expect(service).to be_a(Hash)

      check_hash_structure(service, :current, Hash)
      check_hash_structure(service[:current], :last_updated, String)
      check_hash_structure(service[:current], :temp_f, Float || Integer)
      check_hash_structure(service[:current], :feelslike_f, Float || Integer)
      check_hash_structure(service[:current], :humidity, Integer || Float)
      check_hash_structure(service[:current], :uv, Float)
      check_hash_structure(service[:current], :vis_miles , Float)
      check_hash_structure(service[:current], :condition, Hash)
      check_hash_structure(service[:current][:condition], :text , String)
      check_hash_structure(service[:current][:condition], :icon, String)
    end
    
    it "returns a hash with forecast key associated to forecastday associated to an array of the unidxt", :vcr do
      service = WeatherService.search(coordinates)
      service_unidtx = WeatherService.search(coordinates, 1713956706)

      check_hash_structure(service[:forecast], :forecastday, Array)
      expect(service[:forecast][:forecastday].size).to eq(6)
      expect(service_unidtx[:forecast][:forecastday].size).to eq(1)

      service[:forecast][:forecastday].each do |day_service|
        expect(day_service).to be_a(Hash)
        check_hash_structure(day_service, :date_epoch, Integer)

        check_hash_structure(day_service, :day, Hash)
        check_hash_structure(day_service[:day], :maxtemp_f, Float || Integer)
        check_hash_structure(day_service[:day], :mintemp_f, Float || Integer)
        check_hash_structure(day_service[:day], :totalprecip_mm, Float || Integer)
        check_hash_structure(day_service[:day][:condition], :text, String)
        check_hash_structure(day_service[:day][:condition], :icon, String)

        check_hash_structure(day_service, :astro, Hash)
        check_hash_structure(day_service[:astro], :sunrise, String)
        check_hash_structure(day_service[:astro], :sunset, String)

        check_hash_structure(day_service, :hour, Array)
        expect(day_service[:hour].size).to eq(24)
        check_hash_structure(day_service[:hour].first, :time_epoch, Integer)
        check_hash_structure(day_service[:hour].first, :temp_f, Float || Integer)
        check_hash_structure(day_service[:hour].first[:condition], :text, 
        String)
        check_hash_structure(day_service[:hour].first[:condition], :icon, 
        String)
      end
    end
  end
end