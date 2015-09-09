class CreateUserShips < ActiveRecord::Migration
  def change
    create_table :user_ships do |t|
      t.integer :user_id
      t.integer :ship_id

      t.timestamps null: false
    end
  end
end
