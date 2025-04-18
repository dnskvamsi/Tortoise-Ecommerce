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
class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item, polymorphic: true

  def tortoise
    item if item_type == 'Tortoise'
  end
end
