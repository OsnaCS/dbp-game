class AddExpiditionIDtoFightingFleet < ActiveRecord::Migration
  def change
     add_reference :fighting_fleets, :expidition, index: true
  end
end
