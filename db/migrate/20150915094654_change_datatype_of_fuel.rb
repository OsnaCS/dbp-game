class ChangeDatatypeOfFuel < ActiveRecord::Migration
  def change
  	change_column :ships, :fuel, :float
  end
end
