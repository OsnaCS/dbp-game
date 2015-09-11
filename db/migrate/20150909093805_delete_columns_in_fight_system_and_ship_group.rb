class DeleteColumnsInFightSystemAndShipGroup < ActiveRecord::Migration
  def change
  remove_column :ship_groups, :group_hitpoints
  remove_column :fighting_fleets, :shield
  end
end
