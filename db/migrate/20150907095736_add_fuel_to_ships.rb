class AddFuelToShips < ActiveRecord::Migration
  def change
    add_column :ships, :fuel, :integer
  end
end
