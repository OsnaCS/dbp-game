class AddStateToFightingFleets < ActiveRecord::Migration
  def change
    add_column :fighting_fleets, :state, :integer
  end
end
