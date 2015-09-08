class AddFightingFleetToFight < ActiveRecord::Migration
  def change
    add_reference :fights, :fighting_fleet, index: true
    add_foreign_key :fights, :fighting_fleets
  end
end
