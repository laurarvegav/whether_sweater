require 'rails_helper'

RSpec.describe "Search Controller" do
  describe 'GET #search' do
    before(:each) do
      get "/api/v0/forecast?location=cincinatti,oh"
    end

    it 'returns the weather for a city' do
      expect(response.status).to eq(:success)

      response_data = JSON.parse(response.body, symbolize_names: true)
      
      expect(response_data[:id]).to be_nil

      expect(response_data[:type]).to eq("forecast")

      check_hash_structure(response_data[:attributes], :current_weather, Hash)
      check_hash_structure(response_data[:attributes][:current_weather], :last_updated, String)
      expect(human_readable?(response_data[:attributes][:current_weather][:last_updated])).to be(true)
      check_hash_structure(response_data[:attributes][:current_weather], :temperature, Float)
      check_hash_structure(response_data[:attributes][:current_weather], :feels_like, Float)
      check_hash_structure(response_data[:attributes][:current_weather], :humidity, Float || Integer)
      check_hash_structure(response_data[:attributes][:current_weather], :uvi, Float || Integer)
      check_hash_structure(response_data[:attributes][:current_weather], :visibility, Float || Integer)
      check_hash_structure(response_data[:attributes][:current_weather], :condition, Float || Integer)
      check_hash_structure(response_data[:attributes][:current_weather], :icon, String)

      check_hash_structure(response_data[:attributes], :daily_weather, Hash)
      check_hash_structure(response_data[:attributes][:daily_weather], :date, String)
      expect(human_readable?(response_data[:attributes][:daily_weather][:date])).to be(true)
      check_hash_structure(response_data[:attributes][:daily_weather], :sunrise, String)
      check_hash_structure(response_data[:attributes][:daily_weather], :sunset, String)
      expect(human_readable?(response_data[:attributes][:daily_weather][:sunset])).to be(true)
      check_hash_structure(response_data[:attributes][:daily_weather], :max_temp, Float || Integer)
      check_hash_structure(response_data[:attributes][:daily_weather], :min_temp, Float || Integer)
      check_hash_structure(response_data[:attributes][:daily_weather], :condition, String)
      check_hash_structure(response_data[:attributes][:daily_weather], :icon, String)

      check_hash_structure(response_data[:attributes], :hourly_weather, Array)
      check_hash_structure(response_data[:attributes][:hourly_weather], :time , String)
      expect(human_readable?(response_data[:attributes][:hourly_weather][:time])).to be(true)
      check_hash_structure(response_data[:attributes][:hourly_weather], :temperature , String)
      check_hash_structure(response_data[:attributes][:hourly_weather], :conditions , String)
      check_hash_structure(response_data[:attributes][:hourly_weather], :icon , String)
    end

    xit 'does not return unnecessary data for a city' do
      #Testing should also determine which fields should NOT be present. (don’t send unnecessary data)
    end
  end
end