# == Schema Information
#
# Table name: answers
#
#  id         :bigint           not null, primary key
#  content    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  faq_id     :bigint           not null
#
# Indexes
#
#  index_answers_on_faq_id  (faq_id)
#
# Foreign Keys
#
#  fk_rails_...  (faq_id => faqs.id)
#
class Answer < ApplicationRecord
  belongs_to :faq
end
