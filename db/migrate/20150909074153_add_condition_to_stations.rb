class AddConditionToStations < ActiveRecord::Migration
  def change
    add_column :stations, :condition, :integer
  end
end
