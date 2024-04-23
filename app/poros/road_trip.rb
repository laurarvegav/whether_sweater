class RoadTrip
  attr_reader :origin,
              :duration,
              :destination,
              :forecast
          
  def initialize(data)
    @origin = data[:origin]
    @duration = data[:duration]
    @destination = data[:destination]
    @forecast = data[:forecast]
  end
end