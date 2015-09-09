class CreateSciences < ActiveRecord::Migration
  def change
    create_table :sciences do |t|
      t.integer :science_id
      t.integer :cost1
      t.integer :cost2
      t.integer :cost3
      t.float :factor
      t.time :duration
      t.string :condition
      t.string :name

      t.timestamps null: false
    end
  end
end
