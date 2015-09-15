class ChangeDatatypeOfCristal < ActiveRecord::Migration
  def change
  	change_column :ships, :cristal,  :float
  end
end
