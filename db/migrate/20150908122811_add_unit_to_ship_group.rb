class AddUnitToShipGroup < ActiveRecord::Migration
  def change
    remove_column :ship_groups, :unit_id
    add_reference :ship_groups, :unit, index: true
    add_foreign_key :ship_groups, :units
  end
end
