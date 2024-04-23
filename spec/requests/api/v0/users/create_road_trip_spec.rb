require 'rails_helper'

RSpec.describe "Create Road Trip" do
  before(:each) do
    @user_1 = User.create!({
      email: "person3@test.fake",
      password: "abc123",
      password_confirmation: "abc123"
    })

    @roadt_data = {
      "origin": "Cincinatti,OH",
      "destination": "Chicago,IL",
      "api_key": @user_1.api_key
    }

    @bad_roadt_data_0 = {
      "origin": "Cincinatti,OH",
      "destination": "Chicago,IL",
      "api_key": ""
    }

    @bad_roadt_data_1 = {
      "origin": "",
      "destination": "Chicago,IL",
      "api_key": @user_1.api_key
    }

    @bad_roadt_data_2 = {
      "origin": "Cincinatti,OH",
      "destination": "",
      "api_key": @user_1.api_key
    }

    @bad_roadt_data_3 = {
      "origin": "New York, NY",
      "destination": "London, UK",
      "api_key": @user_1.api_key
    }
  end

  describe '#happy path' do
    it "can create a road trip", :vcr do
      post "/api/v0/road_trip", params: @roadt_data, as: :json

      response_data = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(201)
      check_hash_structure(response_data, :data, Hash)
      check_hash_structure(response_data[:data], :type, String)
      expect(response_data[:data][:type]).to eq("road_trip")
      expect(response_data[:data][:id]).to eq(nil)
      check_hash_structure(response_data[:data], :attributes, Hash)
      check_hash_structure(response_data[:data][:attributes], :start_city, String)
      check_hash_structure(response_data[:data][:attributes], :end_city, String)
      expect(human_readable?(response_data[:data][:attributes][:travel_time])).to be(true)
      check_hash_structure(response_data[:data][:attributes], :weather_at_eta, Hash)
      check_hash_structure(response_data[:data][:attributes][:weather_at_eta], :datetime, String)
      check_hash_structure(response_data[:data][:attributes][:weather_at_eta], :temperature, Float)
      check_hash_structure(response_data[:data][:attributes][:weather_at_eta], :condition, String)
    end
  end

  describe '#sad path' do
    it "will return the correct error message and be unsuccessful if the request comes without api key", :vcr do
      post "/api/v0/road_trip", params: @bad_roadt_data_0, as: :json

      expect(response).not_to be_successful
      expect(response.status).to eq(401)

      error_response = JSON.parse(response.body, symbolize_names: true)

      check_hash_structure(error_response, :errors, Array)

      errors = error_response[:errors].first

      check_hash_structure(errors, :detail, String)
      expect(errors[:detail]).to eq("Unauthorized")
    end

    it "will return the correct error message and be unsuccessful if the origin is incorrect", :vcr do
      post "/api/v0/road_trip", params: @bad_roadt_data_1, as: :json
      
      expect(response).not_to be_successful

      error_response = JSON.parse(response.body, symbolize_names: true)

      check_hash_structure(error_response, :errors, Array)

      errors = error_response[:errors].first

      check_hash_structure(errors, :detail, String)
      expect(errors[:detail]).to eq("Validation failed: origin incorrect")
    end

    xit "will return the correct error message and be unsuccessful if the desination is incorrect", :vcr do
      post "/api/v0/road_trip", params: @bad_roadt_data_2, as: :json
      
      expect(response).not_to be_successful

      error_response = JSON.parse(response.body, symbolize_names: true)

      check_hash_structure(error_response, :errors, Array)

      errors = error_response[:errors].first

      check_hash_structure(errors, :detail, String)
      expect(errors[:detail]).to eq("Validation failed: destination incorrect")
    end

    xit "will return the correct format if the trip is impossible", :vcr do
      post "/api/v0/road_trip", params: @bad_roadt_data_3, as: :json

      expect(response.status).to eq(201)
      check_hash_structure(response_data, :data, Hash)
      check_hash_structure(response_data[:data], :type, String)
      expect(response_data[:data][:type]).to eq("road_trip")
      check_hash_structure(response_data[:data], :id, nil)
      check_hash_structure(response_data[:data], :attributes, Hash)
      check_hash_structure(response_data[:data][:attributes], :start_city, String)
      check_hash_structure(response_data[:data][:attributes], :end_city, String)
      check_hash_structure(response_data[:data][:attributes], :travel_time, String)
      expect(response_data[:data][:attributes][:travel_time]).to eq("impossible")
      check_hash_structure(response_data[:data][:attributes], :weather_at_eta, Hash)
      check_hash_structure(response_data[:data][:attributes], :weather_at_eta, Hash)
      expect(response_data[:data][:attributes][:weather_at_eta].empty?).to eq_(true)
    end
  end
end