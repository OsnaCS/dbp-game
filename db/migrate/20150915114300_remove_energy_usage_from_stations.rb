class RemoveEnergyUsageFromStations < ActiveRecord::Migration
  def change
    remove_column :stations, :energy_usage, :integer
  end
end
