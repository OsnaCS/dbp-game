class AddRessourcesToFightingFleet < ActiveRecord::Migration
  def change
    add_column :fighting_fleets, :metal, :integer
    add_column :fighting_fleets, :crystal, :integer
    add_column :fighting_fleets, :fuel, :integer
  end
end
