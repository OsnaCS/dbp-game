class AddCristalToShips < ActiveRecord::Migration
  def change
    add_column :ships, :cristal, :integer
  end
end
