class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.integer :orderid
      
      t.string :status, null: false, default: 'Pending'
      t.datetime :order_date, null: false
     
      t.timestamps
    end
  end
end
