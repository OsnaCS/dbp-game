class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.int :user_id
      t.int :value

      t.timestamps null: false
    end
  end
end
