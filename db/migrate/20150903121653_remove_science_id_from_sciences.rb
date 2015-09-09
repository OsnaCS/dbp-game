class RemoveScienceIdFromSciences < ActiveRecord::Migration
  def change
    remove_column :sciences, :science_id, :integer
  end
end
