class Api::V0::ForecastsController < ApplicationController
  def city
    forecast = WeatherFacade.city_forecast(params[:location])
    
    output = {
      data: {
        id: nil,
        type: "forecast",
        attributes: forecast
      }
    }
 
    render json: output, status: :ok
  end
end