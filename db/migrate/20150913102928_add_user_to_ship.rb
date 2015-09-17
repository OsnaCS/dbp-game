class AddUserToShip < ActiveRecord::Migration
  def change
    add_reference :ships, :user, index: true
    add_foreign_key :ships, :users
  end
end
