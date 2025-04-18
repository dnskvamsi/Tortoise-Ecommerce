# == Schema Information
#
# Table name: orders
#
#  id               :bigint           not null, primary key
#  discount_code    :string
#  discounted_price :decimal(, )
#  order_date       :datetime         not null
#  orderid          :integer
#  status           :integer          default("pending")
#  total_price      :decimal(10, 2)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :bigint           not null
#
# Indexes
#
#  index_orders_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Order < ApplicationRecord
    belongs_to :user
    has_many :cart_items
    has_many :tortoises, through: :cart_items
    has_many :order_items, dependent: :destroy

    validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
    enum :status, [ :pending, :shipped, :delivered, :cancelled ]
end
