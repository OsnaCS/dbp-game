class CreateRanks < ActiveRecord::Migration
  def change
    create_table :ranks do |t|
      t.string :email
      t.integer :score

      t.timestamps null: false
    end
  end
end
