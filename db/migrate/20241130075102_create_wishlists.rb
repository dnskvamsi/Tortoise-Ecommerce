class CreateWishlists < ActiveRecord::Migration[7.0]
  def change
    create_table :wishlists do |t|
      t.references :user, null: false, foreign_key: true
      t.references :tortoise, null: true, foreign_key: true

      t.timestamps
    end
  end
end
