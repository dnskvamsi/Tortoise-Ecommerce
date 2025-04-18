# == Schema Information
#
# Table name: likes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  profile_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_likes_on_profile_id  (profile_id)
#  index_likes_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (profile_id => profiles.id)
#  fk_rails_...  (user_id => users.id)
#
class Like < ApplicationRecord
  belongs_to :user
  belongs_to :profile

  validates :user_id, uniqueness: { scope: :profile_id }
end
