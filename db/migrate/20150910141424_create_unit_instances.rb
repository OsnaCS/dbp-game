class CreateUnitInstances < ActiveRecord::Migration
  def change
    create_table :unit_instances do |t|
      t.integer :unit_id
      t.integer :ship_id
      t.integer :amount

      t.timestamps null: false
    end
  end
end
