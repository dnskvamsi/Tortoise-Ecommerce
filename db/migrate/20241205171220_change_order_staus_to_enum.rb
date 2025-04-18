class ChangeOrderStausToEnum < ActiveRecord::Migration[7.0]
  def up
    remove_column :orders, :status
    add_column :orders, :status, :integer, default: 0
  end

  def down
    remove_column :orders, :status, :integer
    add_column :orders, :status, :string
  end
end
