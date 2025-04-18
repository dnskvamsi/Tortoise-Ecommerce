# == Schema Information
#
# Table name: order_items
#
#  id         :bigint           not null, primary key
#  item_type  :string
#  price      :decimal(, )
#  quantity   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  item_id    :integer
#  order_id   :bigint           not null
#
# Indexes
#
#  index_order_items_on_order_id  (order_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#
require "test_helper"

class OrderItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
