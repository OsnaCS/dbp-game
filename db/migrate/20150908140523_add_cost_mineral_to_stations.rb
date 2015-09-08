class AddCostMineralToStations < ActiveRecord::Migration
  def change
  	add_column :stations, :costMineral, :integer
  end
end
