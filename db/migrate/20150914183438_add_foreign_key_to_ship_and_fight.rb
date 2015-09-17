class AddForeignKeyToShipAndFight < ActiveRecord::Migration
  def change
    remove_column :fights, :ship_attack_id
    remove_column :fights, :ship_defend_id
    add_reference :fights, :ship_attack, references: :ships, index: true, foreign_key: true
    add_reference :fights, :ship_defend, references: :users, index: true, foreign_key:true
    add_reference :ships, :fight_defends, references: :fights, index: false, foreign_key:true
    add_reference :ships, :fight_attacks, references: :fights, index: false, foreign_key:true
  end
end
