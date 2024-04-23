require 'rails_helper'

Rspec.describe "Munchies and Forecast" do
  before do
    @user_1 = User.create!({
      email: "person3@test.fake",
      password: "abc123",
      password_confirmation: "abc123"
    })

    @destination= "pueblo,co",
    @food= "italian"
  end

  describe "#happy path" do
    it "retrieves food and forecast information for a destination city" do
      get "/api/v1/munchies?destination=#{@destination}&food=#{@italian}"

      response_data = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(201)
      check_hash_structure(response_data, :data, Hash)
      check_hash_structure(response_data[:data], :type, String)
      expect(response_data[:data][:type]).to eq("munchie")
      expect(response_data[:data][:id]).to eq(nil)
      check_hash_structure(response_data[:data], :attributes, Hash)
      check_hash_structure(response_data[:data][:attributes], :destination_city, String)
      check_hash_structure(response_data[:data][:attributes], :forecast, Hash)
      check_hash_structure(response_data[:data][:attributes][:weather_at_eta], :summary, String)
      check_hash_structure(response_data[:data][:attributes][:weather_at_eta], :temperature, Float)
      check_hash_structure(response_data[:data][:attributes], :restaurant, Hash)
      check_hash_structure(response_data[:data][:attributes][:restaurant], :name, Hash)
      check_hash_structure(response_data[:data][:attributes][:restaurant], :address, Hash)
      check_hash_structure(response_data[:data][:attributes][:restaurant], :rating, Float)
      check_hash_structure(response_data[:data][:attributes][:restaurant], :reviews, Integer)
    end
  end
end