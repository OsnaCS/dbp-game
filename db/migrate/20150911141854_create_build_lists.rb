class CreateBuildLists < ActiveRecord::Migration
  def change
    create_table :build_lists do |t|

      t.timestamps null: false
    end
  end
end
