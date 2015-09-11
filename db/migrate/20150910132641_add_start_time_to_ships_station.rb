class AddStartTimeToShipsStation < ActiveRecord::Migration
  def change
    add_column :ships_stations, :start_time, :time
  end
end
