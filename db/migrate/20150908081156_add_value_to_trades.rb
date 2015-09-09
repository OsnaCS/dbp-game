class AddValueToTrades < ActiveRecord::Migration
  def change
    add_column :trades, :value, :decimal
  end
end
