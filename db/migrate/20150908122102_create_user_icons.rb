class CreateUserIcons < ActiveRecord::Migration
  def change
    create_table :user_icons do |t|
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
