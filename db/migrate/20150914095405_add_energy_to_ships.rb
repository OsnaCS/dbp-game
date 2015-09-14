class AddEnergyToShips < ActiveRecord::Migration
  def change
    add_column :ships, :energy, :integer
  end
end
