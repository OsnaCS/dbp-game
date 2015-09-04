class AddNameToFightingFleet < ActiveRecord::Migration
  def change
    add_column :fighting_fleets, :name, :string
  end
end
