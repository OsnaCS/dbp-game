class RemoveStartTimeFromShipsStations < ActiveRecord::Migration
  def change
    remove_column :ships_stations, :start_time, :time
  end
end
