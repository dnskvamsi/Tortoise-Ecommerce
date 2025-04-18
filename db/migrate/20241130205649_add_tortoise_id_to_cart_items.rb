class AddTortoiseIdToCartItems < ActiveRecord::Migration[7.0]
  def change
    add_column :cart_items, :tortoise_id, :integer
  end
end
