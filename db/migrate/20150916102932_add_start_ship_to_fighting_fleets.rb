class AddStartShipToFightingFleets < ActiveRecord::Migration
  def change
    add_column :fighting_fleets, :start_ship, :integer
  end
end
