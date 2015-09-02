class CreateStationsInstances < ActiveRecord::Migration
  def change
    create_table :stations_instances do |t|
      t.integer :shipID
      t.integer :statID
      t.integer :level

      t.timestamps null: false
    end
  end
end
