class AddShipToFight < ActiveRecord::Migration
  def change
    add_reference :fights, :ship, index: true
    add_foreign_key :fights, :ships
  end
end
