class AddInfoToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :info, :string
  end
end
