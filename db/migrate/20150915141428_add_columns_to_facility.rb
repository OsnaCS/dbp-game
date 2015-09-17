class AddColumnsToFacility < ActiveRecord::Migration
  def change
    add_column :facilities, :damage, :integer
    add_column :facilities, :shell, :integer
    add_reference :facilities, :damage_type, index: true, foreign_key: true
  end
end
