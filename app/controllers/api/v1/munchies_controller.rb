class Api::V1::MunchiesController < ApplicationController
  def search
    output = {
      data: {
        id: nil,
        type: "munchie",
        attributes: {
          destination_city: params[:destination],
          forecast: forecast,
          restaurant: munchie
        }
      }
    }
    render json: output, status: 201
  end

  def munchie
    munchie = BusinessFacade.find_munchie(munchie_params)
    
    {
      name: munchie.name,
      address: munchie.address,
      rating: munchie.rating,
      reviews: munchie.reviews
    }
  end

  def forecast
    coordinates = LocationFacade.format_coordinates(params[:destination])

    forecast = WeatherFacade.city_forecast(coordinates)

    {
      temperature: forecast.current_weather[:temperature],
      summary: forecast.current_weather[:condition]
    }
  end

  private
  def munchie_params
    params.permit(:destination, :food)
  end
end