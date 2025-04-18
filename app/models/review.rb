# == Schema Information
#
# Table name: reviews
#
#  id           :bigint           not null, primary key
#  comment      :text
#  rating       :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  accessory_id :bigint
#  tortoise_id  :bigint
#  user_id      :bigint           not null
#
# Indexes
#
#  index_reviews_on_accessory_id  (accessory_id)
#  index_reviews_on_tortoise_id   (tortoise_id)
#  index_reviews_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (accessory_id => accessories.id)
#  fk_rails_...  (tortoise_id => tortoises.id)
#  fk_rails_...  (user_id => users.id)
#
class Review < ApplicationRecord
  belongs_to :user
  belongs_to :tortoise, optional: true
  belongs_to :accessory, optional: true
end
