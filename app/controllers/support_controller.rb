class SupportController < ApplicationController
  before_action :authenticate_user!

  def index
    @chat_session = current_user.chat_sessions.first
  end
end
