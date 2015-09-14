class AddConditionToFacilities < ActiveRecord::Migration
  def change
    add_column :facilities, :condition, :string
  end
end
