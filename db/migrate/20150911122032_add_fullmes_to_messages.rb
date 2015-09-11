class AddFullmesToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :fullmes, :text
  end
end
