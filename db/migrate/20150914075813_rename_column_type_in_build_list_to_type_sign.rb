class RenameColumnTypeInBuildListToTypeSign < ActiveRecord::Migration
  def change
  	rename_column :build_lists, :type, :typeSign
  end
end
