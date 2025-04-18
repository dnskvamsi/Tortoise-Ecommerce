class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :apartment_no
      t.string :street_address
      t.string :city
      t.string :state
      t.string :pin_code
      t.string :address_type
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
