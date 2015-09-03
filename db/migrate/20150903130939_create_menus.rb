class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :title
      t.string :link
      t.string :image
      t.integer :index

      t.timestamps null: false
    end
  end
end
