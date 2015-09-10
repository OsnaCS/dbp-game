class RemoveNameFromFightingFleet < ActiveRecord::Migration
  def change
    remove_column :fighting_fleets, :name
  end
end
