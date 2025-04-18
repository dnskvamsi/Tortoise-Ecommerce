# == Schema Information
#
# Table name: cart_items
#
#  id           :bigint           not null, primary key
#  price        :decimal(10, 2)
#  quantity     :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  accessory_id :bigint
#  cart_id      :bigint           not null
#  tortoise_id  :integer
#
# Indexes
#
#  index_cart_items_on_accessory_id  (accessory_id)
#  index_cart_items_on_cart_id       (cart_id)
#
# Foreign Keys
#
#  fk_rails_...  (accessory_id => accessories.id)
#  fk_rails_...  (cart_id => carts.id)
#
require "test_helper"

class CartItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
