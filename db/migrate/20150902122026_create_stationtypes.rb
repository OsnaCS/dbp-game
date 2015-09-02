class CreateStationtypes < ActiveRecord::Migration
  def change
    create_table :stationtypes do |t|
      t.integer :statID
      t.text :name
      t.integer :costMineral
      t.integer :costCristal
      t.integer :costFuel

      t.timestamps null: false
    end
  end
end
