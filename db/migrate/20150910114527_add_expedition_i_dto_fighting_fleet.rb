class AddExpeditionIDtoFightingFleet < ActiveRecord::Migration
  def change
     add_reference :fighting_fleets, :expedition, index: true
  end
end
