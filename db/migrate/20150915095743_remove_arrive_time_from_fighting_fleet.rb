class RemoveArriveTimeFromFightingFleet < ActiveRecord::Migration
  def change
    remove_column :fighting_fleets, :arrive_time, :timestamp
  end
end
