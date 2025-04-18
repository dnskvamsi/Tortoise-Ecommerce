# == Schema Information
#
# Table name: messages
#
#  id              :bigint           not null, primary key
#  content         :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  chat_session_id :bigint           not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_messages_on_chat_session_id  (chat_session_id)
#  index_messages_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (chat_session_id => chat_sessions.id)
#  fk_rails_...  (user_id => users.id)
#
class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat_session
  validates :content, presence: true
end
