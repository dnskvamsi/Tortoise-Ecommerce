class AddAccessoryRefToReview < ActiveRecord::Migration[7.0]
  def change
    add_reference :reviews, :accessory, null: true, foreign_key: true
  end
end
