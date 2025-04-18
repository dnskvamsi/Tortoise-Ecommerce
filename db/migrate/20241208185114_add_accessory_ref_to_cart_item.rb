class AddAccessoryRefToCartItem < ActiveRecord::Migration[7.0]
  def change
    add_reference :cart_items, :accessory, null: true, foreign_key: true
  end
end
