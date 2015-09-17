class AddDamageTypeToUnit < ActiveRecord::Migration
  def change
    add_reference :units, :damage_type, index: true
    add_foreign_key :units, :damage_types
  end
end
