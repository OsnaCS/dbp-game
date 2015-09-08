class AddIconsToStations < ActiveRecord::Migration
  def change
    add_column :stations, :icon, :string
  end
end
