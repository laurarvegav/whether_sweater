require 'rails_helper'

RSpec.describe "Verify user logging in" do
  before(:each) do
    @user = User.create!({
      email: "person3@woohoo.com",
      password: "abc123",
      password_confirmation: "abc123"
    })

    @login_data = {
      email: "person3@woohoo.com",
      password: "abc123",
    }

    @bad_login_data_1 = {
      email: "person@woohoo.com",
      password: "abc",
    }

    @bad_login_data_2 = {
      email: "test@email.com",
      password: "gurhodngfls;dj"
    }

    @bad_login_data_3 = {
        email: "person@woohoo.com",
        password: ""
      }

    @headers = {"Content_Type" => "application/json", "Accept" => "application/json"}
  end

  describe '#happy path' do
    it "registered user can login with correct credentials", :vcr do
      post "/api/v0/sessions", params:  @login_data, as: :json

      response_data = JSON.parse(response.body, symbolize_names: true)
      session_response = response_data[:data][:attributes]

      expect(response.status).to eq(200)
      
      check_hash_structure(response_data, :data, Hash)
      check_hash_structure(response_data[:data], :type, String)
      expect(response_data[:data][:type]).to eq("users")
      check_hash_structure(response_data[:data], :id, String)
      check_hash_structure(response_data[:data], :attributes, Hash)
      check_hash_structure(response_data[:data][:attributes], :email, String)
      expect(session_response[:email]).to eq(@user.email)
      check_hash_structure(response_data[:data][:attributes], :api_key, String)
    end
  end

  describe '#sad path' do
    it "will return the correct error message and be unsuccessful if the credentials don't match", :vcr do
      post "/api/v0/sessions", params: @bad_login_data_1, as: :json

      expect(response).not_to be_successful

      error_response = JSON.parse(response.body, symbolize_names: true)

      check_hash_structure(error_response, :errors, Array)

      errors = error_response[:errors].first

      check_hash_structure(errors, :detail, String)
      expect(errors[:detail]).to eq("Validation failed: Credentials don't match")
    end

    it "will return the correct error message and be unsuccessful if the email is already associated to a user", :vcr do
      post "/api/v0/sessions", params: @bad_login_data_2, as: :json

      expect(response).not_to be_successful

      error_response = JSON.parse(response.body, symbolize_names: true)

      check_hash_structure(error_response, :errors, Array)

      errors = error_response[:errors].first

      check_hash_structure(errors, :detail, String)
      expect(errors[:detail]).to eq("Validation failed: Credentials don't match")
    end

    it "will return the correct error message and be unsuccessful if any attribute is blank", :vcr do
      post "/api/v0/sessions", params: @bad_login_data_3, as: :json

      expect(response).not_to be_successful

      error_response = JSON.parse(response.body, symbolize_names: true)

      check_hash_structure(error_response, :errors, Array)

      errors = error_response[:errors].first

      check_hash_structure(errors, :detail, String)
      expect(errors[:detail]).to eq("Email can't be blank, Password can't be blank")
    end
  end
end