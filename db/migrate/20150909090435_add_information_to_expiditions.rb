class AddInformationToExpiditions < ActiveRecord::Migration
  def change
    add_column :expiditions, :explore_time, :int
    add_column :expiditions, :arrival_time, :timestamp
    add_reference :expiditions, :fighting_fleet, index: true
    add_foreign_key :expiditions, :fighting_fleets
  end
end
