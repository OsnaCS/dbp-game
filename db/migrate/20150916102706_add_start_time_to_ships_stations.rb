class AddStartTimeToShipsStations < ActiveRecord::Migration
  def change
    add_column :ships_stations, :start_time, :timestamp
  end
end
