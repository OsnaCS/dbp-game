class AddTypeToBuildLists < ActiveRecord::Migration
  def change
    add_column :build_lists, :type, :string
  end
end
