class RoadTripsController < ApplicationController
  def create
    road_trip = ServicesFacade.road_trip(road_trip_params)

    output = {
      data: {
        id: nil,
        type: "road_trip",
        attributes: road_trip
      }
    }
 
    render json: output, status: :ok
  end

  private
  def road_trip_params
    params.permit(:origin, :destination, :api_key)
  end
end