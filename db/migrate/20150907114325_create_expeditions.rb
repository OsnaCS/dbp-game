class CreateExpeditions < ActiveRecord::Migration
  def change
    create_table :expeditions do |t|

      t.timestamps null: false
    end
  end
end
