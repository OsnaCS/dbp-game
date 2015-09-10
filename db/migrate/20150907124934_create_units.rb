class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :name
      t.integer :metal_price
      t.integer :crystal_price
      t.integer :fuel_price
      t.integer :total_cost
      t.integer :shell
      t.integer :damage
      t.references :damage_type, index: true
      t.integer :cargo
      t.integer :speed
      t.integer :shipyard_requirement
      t.integer :research_requirement_one
      t.integer :research_requiement_two

      t.timestamps null: false
    end
    add_foreign_key :units, :damage_types
  end
end
