class AddRightLevelToUser < ActiveRecord::Migration
  def change
    add_column :users, :right_level, :integer, :null => false, :default => 0
  end
end
