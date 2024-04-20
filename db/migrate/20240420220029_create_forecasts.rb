class CreateForecasts < ActiveRecord::Migration[7.1]
  def change
    create_table :forecasts do |t|
      t.text :current_weather
      t.text :daily_weather
      t.text :hourly_weather

      t.timestamps
    end
  end
end
