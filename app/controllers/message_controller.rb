class MessageController < ApplicationController
  before_action :authenticate_user!

  def create
    @message = Message.create(params_for_create.merge(user_id: current_user.id))
    redirect_back_or_to(chat_session_index_path)
  end

  private

  def params_for_create
    params.require(:message).permit(:content, :chat_session_id)
  end
end
