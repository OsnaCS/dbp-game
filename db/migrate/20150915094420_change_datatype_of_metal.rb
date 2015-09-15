class ChangeDatatypeOfMetal < ActiveRecord::Migration
  def change
  	change_column :ships, :metal,  :float
  end
end
