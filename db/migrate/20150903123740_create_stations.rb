class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.text :name
      t.integer :costMIneral
      t.integer :costCristal
      t.integer :costFuel

      t.timestamps null: false
    end
  end
end
