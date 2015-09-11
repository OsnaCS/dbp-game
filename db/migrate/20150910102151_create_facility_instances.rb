class CreateFacilityInstances < ActiveRecord::Migration
  def change
    create_table :facility_instances do |t|
      t.integer :facility_id
      t.integer :ship_id
      t.integer :count
      t.integer :create_count
      t.time :start_time

      t.timestamps null: false
    end
  end
end
