class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items do |t|
      t.references :order, null: false, foreign_key: true
      t.string :item_type
      t.integer :item_id
      t.integer :quantity
      t.decimal :price

      t.timestamps
    end
  end
end
