class AddStationConditionIdToStations < ActiveRecord::Migration
  def change
    add_column :stations, :station_condition_id, :integer
  end
end
