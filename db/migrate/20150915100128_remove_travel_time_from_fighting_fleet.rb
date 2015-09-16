class RemoveTravelTimeFromFightingFleet < ActiveRecord::Migration
  def change
    remove_column :fighting_fleets, :travel_time, :integer
  end
end
