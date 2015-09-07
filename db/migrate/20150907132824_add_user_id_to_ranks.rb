class AddUserIdToRanks < ActiveRecord::Migration
  def change
    add_column :ranks, :user_id, :integer
  end
end
