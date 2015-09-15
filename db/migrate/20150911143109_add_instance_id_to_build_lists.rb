class AddInstanceIdToBuildLists < ActiveRecord::Migration
  def change
    add_column :build_lists, :instance_id, :integer
  end
end
