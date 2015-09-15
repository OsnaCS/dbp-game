class AddEnergyToShips < ActiveRecord::Migration
  def change
    add_column :ships, :energy, :integer, :default => 0
  end
end
