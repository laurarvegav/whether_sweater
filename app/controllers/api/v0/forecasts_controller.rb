class Api::V0::ForecastsController < ApplicationController
  def city
    render json: ForecastSerializer.format_forecast(params[:location])
  end
end