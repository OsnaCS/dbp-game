class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.text :name
      t.integer :production

      t.timestamps null: false
    end
  end
end
