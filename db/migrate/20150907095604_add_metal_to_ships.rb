class AddMetalToShips < ActiveRecord::Migration
  def change
    add_column :ships, :metal, :integer
  end
end
