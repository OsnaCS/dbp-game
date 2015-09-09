class CreateFights < ActiveRecord::Migration
  def change
    create_table :fights do |t|
      t.text :report
      t.timestamp :time

      t.timestamps null: false
    end
  end
end
