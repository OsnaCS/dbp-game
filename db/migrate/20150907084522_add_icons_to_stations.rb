class AddIconsToStations < ActiveRecord::Migration
  def change
    add_column :stations, :icons, :string
  end
end
