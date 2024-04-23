class Api::V1::MunchiesController < ApplicationController
  def search
    output = {
      data: {
        id: nil,
        type: "munchie",
        attributes: {
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
      reviews: munchie.review
    }
  end

  def forecast
    coordinates = LocationFacade.format_coordinates(params[:destination])

    forecast = WeatherFacade.city_forecast(coordinates)

    {
      temperature: forecast.current_weather[:temperature],
      condition: forecast.current_weather[:condition]
    }
  end
end