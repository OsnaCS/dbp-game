class AddLastCheckedToShips < ActiveRecord::Migration
  def change
    add_column :ships, :lastChecked, :timestamp
  end
end
