class RemoveColumnFromRank < ActiveRecord::Migration
  def up
  	remove_column :ranks, :email
  end

  def down
  	add_column :ranks, :user_id, :integer
  end
end