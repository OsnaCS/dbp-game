class AddStartTimeToUnitInstances < ActiveRecord::Migration
  def change
    add_column :unit_instances, :start_time, :timestamp
  end
end
