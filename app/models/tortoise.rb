# == Schema Information
#
# Table name: tortoises
#
#  id            :bigint           not null, primary key
#  elite_design  :string
#  gender        :string
#  name          :string
#  price         :decimal(, )
#  quantity      :integer
#  shell_pattern :string
#  shell_texture :string
#  species       :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint
#
# Indexes
#
#  index_tortoises_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Tortoise < ApplicationRecord
  has_many :wishlists, dependent: :destroy
  has_many :users_wishlisted, through: :wishlists, source: :user
  has_many :cart_items
  has_many :carts, through: :cart_items
  has_many :order_items, as: :item
  has_many :reviews, dependent: :destroy
  has_many :reviewers, through: :reviews, source: :user
  belongs_to :user

  def avg_rating
    return unless reviews.exists?
    (reviews.map(&:rating).sum/reviews.count).round(1)
  end
end
