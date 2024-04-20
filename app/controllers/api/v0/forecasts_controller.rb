class Api::V0::ForecastsController < ApplicationController
  def city
    ForecastSerializer.return_city_weather(params[:location])
  end
end