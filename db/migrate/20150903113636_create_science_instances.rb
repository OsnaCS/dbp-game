class CreateScienceInstances < ActiveRecord::Migration
  def change
    create_table :science_instances do |t|
      t.integer :science_id
      t.integer :user_id
      t.integer :level

      t.timestamps null: false
    end
  end
end
