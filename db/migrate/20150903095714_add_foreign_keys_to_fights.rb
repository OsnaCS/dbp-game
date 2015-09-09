class AddForeignKeysToFights < ActiveRecord::Migration
  def change
    add_reference :fights, :attacker, references: :users, index: true
    add_reference :fights, :defender, references: :users, index: true
  end
end
