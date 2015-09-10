class ChangeStationConditionToString < ActiveRecord::Migration
  def change
    change_column :stations, :condition, :string
  end
end
