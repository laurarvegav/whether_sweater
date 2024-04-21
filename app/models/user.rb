class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :password, presence: { on: :create }, confirmation: true 

  has_secure_password
end
