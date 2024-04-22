require 'securerandom'

class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :password, presence: { on: :create }

  has_secure_password
  before_create :generate_api_key

  def generate_api_key
    self.api_key = SecureRandom.base64(24)
  end
end
