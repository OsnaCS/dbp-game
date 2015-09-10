class CreateFacilities < ActiveRecord::Migration
  def change
    create_table :facilities do |t|
      t.int :cost1
      t.int :cost2
      t.int :cost3
      t.int :duration
      t.string :name
      t.int :facility_condition_id
      t.string :icon

      t.timestamps null: false
    end
  end
end
