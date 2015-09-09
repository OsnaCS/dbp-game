class FixColumnNameForUnit < ActiveRecord::Migration
  def change
    rename_column :units, :research_requiement_two, :research_requirement_two
  end
end
