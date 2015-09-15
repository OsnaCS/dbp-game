class AddStartTimeToFacilityInstances < ActiveRecord::Migration
  def change
    add_column :facility_instances, :start_time, :timestamp
  end
end
