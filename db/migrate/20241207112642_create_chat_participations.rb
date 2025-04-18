class CreateChatParticipations < ActiveRecord::Migration[7.0]
  def change
    create_table :chat_participations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :chat_session, null: false, foreign_key: true

      t.timestamps
    end
  end
end
