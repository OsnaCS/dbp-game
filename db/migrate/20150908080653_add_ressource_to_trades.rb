class AddRessourceToTrades < ActiveRecord::Migration
  def change
    add_column :trades, :ressource, :int
  end
end
