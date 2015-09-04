class CreateShipsStations < ActiveRecord::Migration
  def change
    create_table :ships_stations do |t|
      t.belongs_to :ship, index: true
      t.belongs_to :station, index: true
      t.integer :level

      t.timestamps null: false
    end
  end
end
