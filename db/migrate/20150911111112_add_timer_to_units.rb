class AddTimerToUnits < ActiveRecord::Migration
  def change
  	add_column :unit_instances, :start_time, :time
  	add_column :unit_instances, :build_amount, :integer
  end
end
