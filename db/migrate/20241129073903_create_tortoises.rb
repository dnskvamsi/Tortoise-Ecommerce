class CreateTortoises < ActiveRecord::Migration[7.0]
  def change
    create_table :tortoises do |t|
      t.string :name
      t.string :species
      t.string :gender
      t.string :shell_pattern
      t.string :shell_texture
      t.string :elite_design
      t.decimal :price

      t.timestamps
    end
  end
end
