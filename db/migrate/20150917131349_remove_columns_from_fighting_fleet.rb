class RemoveColumnsFromFightingFleet < ActiveRecord::Migration
  def change
    remove_column :fighting_fleets, :crystal, :string
    remove_column :fighting_fleets, :metal, :string
    remove_column :fighting_fleets, :fuel, :string
  end
end
