class AddMissionToFightingFleet < ActiveRecord::Migration
  def change
    add_column :fighting_fleets, :mission, :integer
  end
end
