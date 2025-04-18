# == Schema Information
#
# Table name: accessories
#
#  id         :bigint           not null, primary key
#  gender     :string
#  name       :string
#  price      :decimal(, )
#  quantity   :decimal(, )
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_accessories_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Accessory < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :reviewers, through: :reviews, source: :user
  has_many :cart_items
  has_many :carts, through: :cart_items
  has_many :order_items, as: :item
  has_many :wishlists, dependent: :destroy

  def avg_rating
    return unless reviews.exists?
    (reviews.map(&:rating).sum/reviews.count).round(1)
  end
end
