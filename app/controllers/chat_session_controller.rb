class ChatSessionController < ApplicationController
  before_action :authenticate_user!

  def create
    chat_session = ChatSession.create
    ChatParticipation.create(user: current_user, chat_session: chat_session)
    redirect_to chat_session_path(chat_session)
  end

  def add_participant
    ChatParticipation.find_or_create_by(user: current_user, chat_session_id: params[:chat_session_id])
    redirect_to chat_session_path(params[:chat_session_id])
  end

  def show
    @chat_session = ChatSession.find(params[:id])
  end

  def index
    @chat_sessions = current_user.chat_sessions.order(:created_at)
  end
end
