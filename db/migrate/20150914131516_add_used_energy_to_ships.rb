class AddUsedEnergyToShips < ActiveRecord::Migration
  def change
    add_column :ships, :used_energy, :integer, :default => 0
  end
end
