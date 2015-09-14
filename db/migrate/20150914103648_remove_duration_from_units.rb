class RemoveDurationFromUnits < ActiveRecord::Migration
  def change
    remove_column :units, :duration, :integer
  end
end
