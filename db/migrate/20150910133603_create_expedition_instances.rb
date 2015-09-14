class CreateExpeditionInstances < ActiveRecord::Migration
  def change
    create_table :expedition_instances do |t|
      t.integer :user_id
      t.integer :expedition_id

      t.timestamps null: false
    end
  end
end
