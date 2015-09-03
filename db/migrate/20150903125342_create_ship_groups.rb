class CreateShipGroups < ActiveRecord::Migration
  def change
    create_table :ship_groups do |t|
      t.references :fleet, index: true
      t.references :ship, index: true
      t.int :number
      t.float :group_hitpoints

      t.timestamps null: false
    end
    add_foreign_key :ship_groups, :fleets
    add_foreign_key :ship_groups, :ships
  end
end
