require 'active_support/all'
class LocationFacade

  def self.format_coordinates(city)
    data = LocationService.search(city)
    coordinates = data[:results].first[:locations].first[:latLng]

    coordinates.values.join(',')
  end

  def self.road_trip_time(params)
    data = LocationService.road_trip(params[:origin], params[:destination])
    
    time_string = data[:route][:formattedTime]
    
    hours, minutes, seconds = time_string.split(':').map(&:to_i)

    # Construct a ActiveSupport::Duration object
    duration = 1.day + hours.hours + minutes.minutes + seconds.seconds

    {
      time: time_string,
      duration: duration
    }
  end
end