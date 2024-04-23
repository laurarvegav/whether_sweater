class RoadTrip
  attr_reader :origin,
              :duration,
              :destination
          
  def initialize(data)
    @origin = data[:origin]
    @duration = data[:duration]
    @destination = data[:destination]
  end

  def weather_at_eta(current_weather)
    {
      datetime: current_weather[:last_updated],
      temperature: current_weather[:temperature],
      condition: current_weather[:condition]
    }
  end
end