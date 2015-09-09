class AddIconToSciences < ActiveRecord::Migration
  def change
    add_column :sciences, :icon, :string
  end
end
