class CreateAccessories < ActiveRecord::Migration[7.0]
  def change
    create_table :accessories do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :gender
      t.decimal :price
      t.decimal :quantity

      t.timestamps
    end
  end
end
