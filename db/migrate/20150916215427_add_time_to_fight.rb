class AddTimeToFight < ActiveRecord::Migration
  def change
    add_column :fights, :time, :timestamp
  end
end
