class AddPaymentDetailsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :card_holder_name, :string
    add_column :users, :card_number, :string
    add_column :users, :expiry_date, :string
    add_column :users, :cvv, :string
  end
end
