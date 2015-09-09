class AddTierToStations < ActiveRecord::Migration
  def change
    add_column :stations, :tier, :integer
  end
end
