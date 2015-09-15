class AddStartTimeToFightingFleets < ActiveRecord::Migration
  def change
    add_column :fighting_fleets, :start_time, :timestamp
  end
end
