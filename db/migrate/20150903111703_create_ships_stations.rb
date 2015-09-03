class CreateShipsStations < ActiveRecord::Migration
  def change
    create_table :ships_stations do |t|
      t.integer :ships_id
      t.integer :stationtypes_id
      t.integer :level

      t.timestamps null: false
    end
  end
end
