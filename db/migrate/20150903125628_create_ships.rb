class CreateShips < ActiveRecord::Migration
  def change
    create_table :ships do |t|

      t.timestamps null: false
    end
  end
end
