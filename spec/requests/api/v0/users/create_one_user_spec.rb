require 'rails_helper'

RSpec.describe "Create User in DB via HTTP Request" do
  before(:each) do
    @user_data = {
      "email" => "person@woohoo.com",
      "password" => "abc123",
      "password_confirmation" => "abc123"
    }

    @bad_user_data_1 = {
      email: "test@email.com",
      password: "abc123",
      password_confirmation: "abc12"
    }

    @bad_user_data_2 = {
      email: "test@email.com",
      password: "abc123"
    }

    @headers = {"Content_Type" => "application/json", "Accept" => "application/json"}
  end

  describe '#happy path' do
    it "can create a new user", :vcr do
      post "/api/v0/users", headers: @headers, params: JSON.generate(user: @user_data)

      new_user = User.last
      response_data = JSON.parse(response.body, symbolize_names: true)

      expect(new_user.name).to eq(@user_data[:name])
      expect(new_user.location).to eq(@user_data[:location])
      expect(new_user.email).to eq(@user_data[:email])
      expect(new_user.search_radius).to eq(@user_data[:search_radius])
      expect(new_user.password_digest).to be_a(String)
      
      expect(response[:status]).to eq(201)
      check_hash_structure(response_data, :data, Hash)
      check_hash_structure(response_data[:data], :type, String)
      check_hash_structure(response_data[:data], :id, String)
      check_hash_structure(response_data[:data], :attributes, Hash)
      check_hash_structure(response_data[:data][:attributes], :email, String)
      check_hash_structure(response_data[:data][:attributes], :api_key, String)
    end
  end

  describe '#sad path' do
    it "will return the correct error message and be unsuccessful if the passwords don't match", :vcr do
      post "/api/v0/users", headers: @headers, params: JSON.generate(user: @bad_user_data_1)
      
      expect(response).not_to be_successful

      error_response = JSON.parse(response.body, symbolize_names: true)

      check_hash_structure(error_response, :errors, Array)

      errors = error_response[:errors].first

      check_hash_structure(errors, :detail, String)
      expect(errors[:detail]).to eq("Validation failed: Passwords don't match")
    end

    it "will return the correct error message and be unsuccessful if any attribute is left blank", :vcr do
      post "/api/v0/users", headers: @headers, params: JSON.generate(user: @bad_user_data_2)

      expect(response).not_to be_successful

      error_response = JSON.parse(response.body, symbolize_names: true)

      check_hash_structure(error_response, :errors, Array)

      errors = error_response[:errors].first

      check_hash_structure(errors, :detail, String)
      expect(errors[:detail]).to eq("Validation failed: Password Confirmation can't be blank")
    end

    it "will return the correct error message and be unsuccessful if the email is already associated to a user", :vcr do
      post "/api/v0/users", headers: @headers, params: JSON.generate(user: @user_data)

      bad_user_data_3 = {
        email: "person@woohoo.com",
        password: "abc123",
        password_confirmation: "abc12"
      }

      post "/api/v0/users", headers: @headers, params: JSON.generate(user: bad_user_data_3)

      expect(response).not_to be_successful

      error_response = JSON.parse(response.body, symbolize_names: true)

      check_hash_structure(error_response, :errors, Array)

      errors = error_response[:errors].first

      check_hash_structure(errors, :detail, String)
      expect(errors[:detail]).to eq("Validation failed: Incorrect combination of parameters")
    end
  end
end