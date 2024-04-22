class DropForecastsTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :forecasts
  end
end
