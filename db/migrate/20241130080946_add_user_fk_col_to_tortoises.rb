class AddUserFkColToTortoises < ActiveRecord::Migration[7.0]
  def change
    add_reference :tortoises, :user, foreign_key: true
  end
end
