class CreateExpiditions < ActiveRecord::Migration
  def change
    create_table :expiditions do |t|

      t.timestamps null: false
    end
  end
end
