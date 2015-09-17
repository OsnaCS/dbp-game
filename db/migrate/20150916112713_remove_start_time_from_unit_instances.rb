class RemoveStartTimeFromUnitInstances < ActiveRecord::Migration
  def change
    remove_column :unit_instances, :start_time, :time
  end
end
