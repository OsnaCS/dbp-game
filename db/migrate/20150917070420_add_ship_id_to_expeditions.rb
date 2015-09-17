class AddShipIdToExpeditions < ActiveRecord::Migration
  def change
  	add_column :expeditions, :ship_id, :integer
  end
end
