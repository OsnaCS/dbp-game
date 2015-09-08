class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :mes
      t.integer :code

      t.timestamps null: false
    end
  end
end
