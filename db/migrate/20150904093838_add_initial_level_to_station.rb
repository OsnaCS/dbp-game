class AddInitialLevelToStation < ActiveRecord::Migration
  def change
    add_column :stations, :initial_level, :integer
  end
end
