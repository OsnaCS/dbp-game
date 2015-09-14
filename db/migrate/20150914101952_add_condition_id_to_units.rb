class AddConditionIdToUnits < ActiveRecord::Migration
  def change
    add_column :units, :condition_id, :integer
  end
end
