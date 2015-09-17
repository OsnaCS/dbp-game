class ChangeStartTimeForScienceInstances < ActiveRecord::Migration
  def change
    change_table :science_instances do |t|
      t.remove :start_time
      t.timestamp :start_time
    end
  end
end
