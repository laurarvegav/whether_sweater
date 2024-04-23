class RoadTrip
  attr_reader :start_city, :end_city

  def initialize(data)
    @start_city = data[:origin]
    @end_city = data[:desination]
  end
end