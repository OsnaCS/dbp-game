class AddShipIdToBuildLists < ActiveRecord::Migration
  def change
    add_column :build_lists, :ship_id, :integer
  end
end
