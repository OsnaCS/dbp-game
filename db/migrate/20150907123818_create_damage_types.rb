class CreateDamageTypes < ActiveRecord::Migration
  def change
    create_table :damage_types do |t|
      t.string :name
      t.float :shell_mult
      t.float :shield_mult
      t.float :station_mult
      t.float :plattform_mult

      t.timestamps null: false
    end
  end
end
