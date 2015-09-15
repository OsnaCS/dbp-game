class RemoveStartTimeFromFacilityInstances < ActiveRecord::Migration
  def change
  	remove_column :facility_instances, :start_time, :time
  end
end
