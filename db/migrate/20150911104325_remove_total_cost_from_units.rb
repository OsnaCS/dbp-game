class RemoveTotalCostFromUnits < ActiveRecord::Migration
  def change
    remove_column :units, :total_cost, :integer
  end
end
