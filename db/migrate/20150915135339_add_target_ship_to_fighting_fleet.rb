class AddTargetShipToFightingFleet < ActiveRecord::Migration
  def change
    add_column :fighting_fleets, :target_ship, :integer
  end
end
