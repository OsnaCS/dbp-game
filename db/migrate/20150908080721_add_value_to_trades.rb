class AddValueToTrades < ActiveRecord::Migration
  def change
    add_column :trades, :value, :double
  end
end
