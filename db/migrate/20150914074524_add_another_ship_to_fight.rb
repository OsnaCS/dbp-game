class AddAnotherShipToFight < ActiveRecord::Migration
  def change
    remove_column :fights, :ship_id
    add_reference :fights, :ship_attack, references: :ships, index: true
    add_reference :fights, :ship_defend, references: :ships, index: true
  end
end
