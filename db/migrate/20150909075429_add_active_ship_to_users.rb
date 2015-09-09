class AddActiveShipToUsers < ActiveRecord::Migration
  def change
    add_column :users, :activeShip, :integer
  end
end
