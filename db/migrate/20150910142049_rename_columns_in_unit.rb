class RenameColumnsInUnit < ActiveRecord::Migration
  def change
    rename_column :units, :research_requirement_one, :science_one_level
    rename_column :units, :research_requirement_two, :science_two_level
    rename_column :units, :science_one_id, :science_one_instance
    rename_column :units, :science_two_id, :science_two_instance
  end
end
