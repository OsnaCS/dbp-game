class RenameColumnForCostMIneralForStations < ActiveRecord::Migration
  def change
  	rename_column :stations, :costMIneral, :costMineral
  end
end
