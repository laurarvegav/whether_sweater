class Api::V0::UsersController < ApplicationController
  def create
    user = User.create!(user_params)
    render json: UserSerializer.new(user), status: 201
  end

  private
  def user_params
    JSON.parse(params.keys.first).fetch('user', {})
  end
end 