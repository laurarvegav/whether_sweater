require 'rails_helper'

RSpec.describe "Search Controller" do
  describe 'GET #search' do    
    before do
      get "/api/v0/forecast?location=denver,co"
      expect(response.status).to eq(200)

      @response_data = JSON.parse(response.body, symbolize_names: true)[:data]
    end

    it 'returns the weather for a city', :vcr do
      expect(@response_data[:id]).to be_nil

      expect(@response_data[:type]).to eq("forecast")

      check_hash_structure(@response_data[:attributes], :current_weather, Hash)
      check_hash_structure(@response_data[:attributes][:current_weather], :last_updated, String)
      expect(human_readable?(@response_data[:attributes][:current_weather][:last_updated])).to be(true)
      check_hash_structure(@response_data[:attributes][:current_weather], :temperature, Float)
      check_hash_structure(@response_data[:attributes][:current_weather], :feels_like, Float)
      expect(@response_data[:attributes][:current_weather][:humidity]).to be_a_kind_of(Float).or be_a_kind_of(Integer)
      check_hash_structure(@response_data[:attributes][:current_weather], :uvi, Float || Integer)
      check_hash_structure(@response_data[:attributes][:current_weather], :visibility, Float || Integer)
      check_hash_structure(@response_data[:attributes][:current_weather], :condition, String)
      check_hash_structure(@response_data[:attributes][:current_weather], :icon, String)

      check_hash_structure(@response_data[:attributes], :daily_weather, Array)
      @response_data[:attributes][:daily_weather].each do |daily_weather|
        check_hash_structure(daily_weather, :date, String)
        expect(human_readable?(daily_weather[:date])).to be(true)
        check_hash_structure(daily_weather, :sunrise, String)
        check_hash_structure(daily_weather, :sunset, String)
        expect(human_readable?(daily_weather[:sunset])).to be(true)
        check_hash_structure(daily_weather, :max_temp, Float || Integer)
        check_hash_structure(daily_weather, :min_temp, Float || Integer)
        check_hash_structure(daily_weather, :condition, String)
        check_hash_structure(daily_weather, :icon, String)
      end

      check_hash_structure(@response_data[:attributes], :hourly_weather, Array)
      @response_data[:attributes][:hourly_weather].each do |hourly_weather|
        check_hash_structure(hourly_weather, :time , String)
        expect(human_readable?(hourly_weather[:time])).to be(true)
        expect(hourly_weather[:temperature]).to be_a_kind_of(Float).or be_a_kind_of(Integer)
        check_hash_structure(hourly_weather, :conditions , String)
        check_hash_structure(hourly_weather, :icon , String)
      end
    end

    it 'does not return unnecessary data for a city', :vcr do
      expect(@response_data).not_to have_key(:updated_at)
      expect(@response_data).not_to have_key(:created_at)
      
      expect(@response_data[:attributes][:current_weather]).not_to have_key(:is_day)
      expect(@response_data[:attributes][:current_weather]).not_to have_key(:wind_mph)
      expect(@response_data[:attributes][:current_weather]).not_to have_key(:wind_degree)

      expect(@response_data[:attributes][:daily_weather][0]).not_to have_key(:maxwind_mph)
      expect(@response_data[:attributes][:daily_weather][0]).not_to have_key(:avg_humidity)

      expect(@response_data[:attributes][:hourly_weather][0]).not_to have_key(:wind_dir)
      expect(@response_data[:attributes][:hourly_weather][0]).not_to have_key(:cloud)
    end
  end
end