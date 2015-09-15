class AddEnergyUsageToShipsStations < ActiveRecord::Migration
  def change
    add_column :ships_stations, :energy_usage, :integer, :default => 100
  end
end
