class RoadTripsController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])

    if valid?(user)
      output = {
        data: {
          id: nil,
          type: "road_trip",
          attributes: road_trip
        }
      }
 
    render json: output, status: :ok
    else
      render json: ErrorSerializer.new(ErrorMessage.new("Unauthorized", 422)).serialize_json, status: 401
    end
  end

  private
  def road_trip
    service = LocationFacade.find_road_trip(road_trip_params)
    road_t = service[:road_trip]
    {
      start_city: road_t.start_city, 
      end_city: road_t.end_city,
      travel_time: service[:travel_time],
      weather_at_eta: WeatherFacade.road_trip_weather(road_t)
    }
  end

  def road_trip_params
    params.permit(:origin, :destination)
  end
end