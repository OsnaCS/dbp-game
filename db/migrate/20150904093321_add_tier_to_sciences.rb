class AddTierToSciences < ActiveRecord::Migration
  def change
    add_column :sciences, :tier, :integer
  end
end
