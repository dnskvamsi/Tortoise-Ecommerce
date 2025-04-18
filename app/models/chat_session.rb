# == Schema Information
#
# Table name: chat_sessions
#
#  id         :bigint           not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ChatSession < ApplicationRecord
  has_many :chat_participations
  has_many :users, through: :chat_participations
  has_many :messages, dependent: :destroy

  def customer_name
    users.find_by(role: :customer)&.first_name ||'Bob'
  end

  def title
    "Chat Session #{id}"
  end
end
