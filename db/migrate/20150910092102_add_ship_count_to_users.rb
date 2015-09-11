class AddShipCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ship_count, :integer
  end
end
