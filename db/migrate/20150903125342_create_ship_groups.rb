class CreateShipGroups < ActiveRecord::Migration
  def change
    create_table :ship_groups do |t|
      t.references :fighting_fleet, index: true
      t.references :ship, index: true
      t.integer :number
      t.float :group_hitpoints

      t.timestamps null: false
    end
    add_foreign_key :ship_groups, :fighting_fleets
    add_foreign_key :ship_groups, :ships
  end
end
