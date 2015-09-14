class FixUnits < ActiveRecord::Migration
  def change
  	 remove_column :units, :shipyard_requirement, :integer
  	 remove_column :units, :research_requirement_one, :integer
  	 remove_column :units, :research_requirement_two, :integer
  	 add_column :units, :conditions, :string
  	 add_column :units, :duration, :integer
  end
end
