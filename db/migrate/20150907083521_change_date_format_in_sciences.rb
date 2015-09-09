class ChangeDateFormatInSciences < ActiveRecord::Migration
  def change
  	change_column :sciences, :duration, :integer, :using => 0
  end
end
