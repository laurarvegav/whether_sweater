class Api::V0::RoadTripsController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])

    if user
      output = {
        data: {
          id: nil,
          type: "road_trip",
          attributes: road_trip
        }
      }
 
    render json: output, status: 201
    else
      render json: ErrorSerializer.new(ErrorMessage.new("Unauthorized", 422)).serialize_json, status: 401
    end
  end

  private
  def road_trip
    time = LocationFacade.road_trip_time(road_trip_params)
    coordinates = LocationFacade.format_coordinates(params[:destination])

    weather_at_eta = WeatherFacade.road_trip_weather(coordinates, time[:duration])

    {
      start_city: params[:origin], 
      end_city: params[:destination],
      travel_time: time[:time],
      weather_at_eta: weather_at_eta
    }
  end

  def road_trip_params
    params.permit(:origin, :destination)
  end
end