class ChangeNameTypeInShips < ActiveRecord::Migration
  def change
  	change_column :ships, :name, :string
  end
end
