class AddDurationToStations < ActiveRecord::Migration
  def change
    add_column :stations, :duration, :integer
  end
end
