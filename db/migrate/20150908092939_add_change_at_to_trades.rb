class AddChangeAtToTrades < ActiveRecord::Migration
  def change
    add_column :trades, :change_at, :timestamp
  end
end
