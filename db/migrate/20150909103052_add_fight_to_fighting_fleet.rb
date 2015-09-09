class AddFightToFightingFleet < ActiveRecord::Migration
  def change
    add_reference :fighting_fleets, :fight, index: true
    add_foreign_key :fighting_fleets, :fights
  end
end
