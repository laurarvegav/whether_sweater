class Api::V0::ForecastsController < ApplicationController
  def city
    coordinates = LocationFacade.format_coordinates(params[:location])

    forecast = WeatherFacade.city_forecast(coordinates)
    
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