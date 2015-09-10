class RenameColumnShipIdInShipGroupToUnitId < ActiveRecord::Migration
  def change
    rename_column :ship_groups, :ship_id, :unit_id
  end
end
