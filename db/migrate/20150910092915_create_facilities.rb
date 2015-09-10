class CreateFacilities < ActiveRecord::Migration
  def change
    create_table :facilities do |t|
      t.integer :cost1
      t.integer :cost2
      t.integer :cost3
      t.integer :duration
      t.string :name
      t.integer :facility_condition_id
      t.string :icon

      t.timestamps null: false
    end
  end
end
