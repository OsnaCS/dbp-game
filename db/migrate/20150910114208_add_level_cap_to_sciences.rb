class AddLevelCapToSciences < ActiveRecord::Migration
  def change
    add_column :sciences, :level_cap, :integer
  end
end
