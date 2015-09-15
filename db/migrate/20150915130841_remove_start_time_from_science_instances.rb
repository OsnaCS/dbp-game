class RemoveStartTimeFromScienceInstances < ActiveRecord::Migration
  def change
    remove_column :science_instances, :start_time, :time
  end
end
