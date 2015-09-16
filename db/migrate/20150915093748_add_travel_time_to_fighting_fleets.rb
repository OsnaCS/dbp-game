class AddTravelTimeToFightingFleets < ActiveRecord::Migration
  def change
    add_column :fighting_fleets, :travel_time, :integer
  end
end
