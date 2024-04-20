class Forecast < ApplicationRecord
  validates_presence_of :current_weather
  validates_presence_of :daily_weather
  validates_presence_of :hourly_weather

  serialize :current_weather, Hash, coder: JSON
  serialize :daily_weather, Hash, coder: JSON
  serialize :hourly_weather, Array, coder: JSON
end
