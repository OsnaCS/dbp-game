class AddScienceConditionIdToSciences < ActiveRecord::Migration
  def change
    add_column :sciences, :science_condition_id, :integer
  end
end
