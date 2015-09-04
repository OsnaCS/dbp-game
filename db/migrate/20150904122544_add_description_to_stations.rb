class AddDescriptionToStations < ActiveRecord::Migration
  def change
    add_column :stations, :description, :text
  end
end
