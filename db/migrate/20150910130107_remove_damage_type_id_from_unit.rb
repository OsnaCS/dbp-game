class RemoveDamageTypeIdFromUnit < ActiveRecord::Migration
  def change
    remove_column :units, :damage_type_id
  end
end
