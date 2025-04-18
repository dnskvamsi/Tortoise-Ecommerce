# == Schema Information
#
# Table name: chat_participations
#
#  id              :bigint           not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  chat_session_id :bigint           not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_chat_participations_on_chat_session_id  (chat_session_id)
#  index_chat_participations_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (chat_session_id => chat_sessions.id)
#  fk_rails_...  (user_id => users.id)
#
class ChatParticipation < ApplicationRecord
  belongs_to :user
  belongs_to :chat_session

  validates :user_id, uniqueness: { scope: :chat_session_id, message: "is already a participant in this session" }
end
