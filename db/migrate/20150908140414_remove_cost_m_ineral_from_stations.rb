class RemoveCostMIneralFromStations < ActiveRecord::Migration
  def change
  	remove_column :stations, :costMIneral
  end
end
