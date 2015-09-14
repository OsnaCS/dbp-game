class AddInformationToExpeditions < ActiveRecord::Migration
  def change
    add_column :expeditions, :explore_time, :int
    add_column :expeditions, :arrival_time, :timestamp
    add_reference :expeditions, :fighting_fleet, index: true
    add_foreign_key :expeditions, :fighting_fleets
  end
end
