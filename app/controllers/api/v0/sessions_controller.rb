class Api::V0::SessionsController < ApplicationController
  before_action :complete_params

  def create
    user = User.find_by(email: params[:email])

    if valid?(user)
      render json: UsersSerializer.new(user), status: 200
    else
      render json: ErrorSerializer.new(ErrorMessage.new("Validation failed: Credentials don't match", 422)).serialize_json, status: 422
    end
  end

  private
  def complete_params
    if params.has_value?("")
      render json: ErrorSerializer.new(ErrorMessage.new("Email can't be blank, Password can't be blank", 404)).serialize_json, status: 404
    end
  end

  def valid?(user)
    user && user.authenticate(params[:password])
  end
end