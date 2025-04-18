# == Schema Information
#
# Table name: faqs
#
#  id         :bigint           not null, primary key
#  question   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_faqs_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Faq < ApplicationRecord
  belongs_to :user
  has_many :answers
end
