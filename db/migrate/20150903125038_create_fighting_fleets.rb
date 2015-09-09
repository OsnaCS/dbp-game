class CreateFightingFleets < ActiveRecord::Migration
  def change
    create_table :fighting_fleets do |t|
      t.float :shield
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :fighting_fleets, :users
  end
end
