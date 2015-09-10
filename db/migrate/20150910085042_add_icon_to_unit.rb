class AddIconToUnit < ActiveRecord::Migration
  def change
    add_column :units, :icon, :string
  end
end
