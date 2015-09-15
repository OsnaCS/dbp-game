class AddStartTimeToScienceInstances < ActiveRecord::Migration
  def change
    add_column :science_instances, :start_time, :timestamp
  end
end
