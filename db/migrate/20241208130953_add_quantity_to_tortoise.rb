class AddQuantityToTortoise < ActiveRecord::Migration[7.0]
  def change
    add_column :tortoises, :quantity, :integer
  end
end
