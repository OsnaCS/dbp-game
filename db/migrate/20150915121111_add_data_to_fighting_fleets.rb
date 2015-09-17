class AddDataToFightingFleets < ActiveRecord::Migration
  def change
    add_column :fighting_fleets, :data, :text
  end
end
