class RemoveShipAttackFromFight < ActiveRecord::Migration
  def change
    remove_reference :fights, :ship_attack, index: true
  end
end
