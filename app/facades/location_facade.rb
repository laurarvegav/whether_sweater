class LocationFacade

  def self.format_coordinates(city)
    coordinates = LocationService.search(city)

    coordinates.values.join(',')
  end
  
  def self.find_road_trip(road_trip_params)
    
  end
end