require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_confirmation_of(:password) }
  end

  describe "instance methods" do
    before do
      @user_data = {
        email: "person1@woohoo.com",
        password: "abc123",
        password_confirmation: "abc123"
      }
  
      @bad_user_data_1 = {
        email: "test@email.com",
        password: "abc123",
        password_confirmation: "abc12"
      }
    end

    describe "#generate_api_key" do
      it "creates api_key upon creation" do
        user = User.create!(@user_data)
  
        expect(user.api_key).not_to be_nil
      end
    end
  end
end
