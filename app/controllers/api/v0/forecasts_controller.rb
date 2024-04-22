class Api::V0::ForecastsController < ApplicationController
  def city
    forecast = ServicesFacade.city_forecast(params[:location])
    render json: ForecastSerializer.new(forecast)
  end
end