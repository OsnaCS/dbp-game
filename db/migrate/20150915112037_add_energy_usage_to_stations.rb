class AddEnergyUsageToStations < ActiveRecord::Migration
  def change
    add_column :stations, :energy_usage, :integer, :default => 100
  end
end
