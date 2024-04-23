class Api::V0::RoadTripsController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])

    if user 
      if road_trip_params[:origin].blank?
        render_error("Validation failed: origin incorrect", 422)
      elsif road_trip_params[:destination].blank?
        render_error("Validation failed: destination incorrect", 422)
      else

        road_trip = RoadTrip.new(
          origin: params[:origin],
          destination: params[:destination],
          duration: trip_duration,
          forecast: road_trip_weather
          )
          
        output = {
          data: {
            id: nil,
            type: "road_trip",
            attributes: road_trip_attributes(road_trip)
          }
        }
          
        render json: output, status: 201
      end
    else
      render json: ErrorSerializer.new(ErrorMessage.new("Unauthorized", 422)).serialize_json, status: 401
    end
  end

  private

  def trip_duration
    LocationFacade.road_trip_time(road_trip_params)[:duration]
  end

  def road_trip_weather
      coordinates = LocationFacade.format_coordinates(params[:destination])
      WeatherFacade.city_forecast(coordinates, trip_duration).current_weather
  end

  def road_trip_attributes(road_trip)
    attributes = {
      start_city: road_trip.origin,
      end_city: road_trip.destination,
      travel_time: road_trip.duration,
    }

    if trip_duration != "impossible"
      attributes[:weather_at_eta] = road_trip.weather_at_eta(road_trip_weather)
    else
      attributes[:weather_at_eta] = {}
    end
    attributes
  end

  def road_trip_params
    params.permit(:origin, :destination)
  end

  def render_error(detail, status)
    render json: ErrorSerializer.new(ErrorMessage.new(detail, status)).serialize_json, status: status
  end
end