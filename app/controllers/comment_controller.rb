class CommentController < ApplicationController
  before_action :authenticate_user!

  def create
    comment = current_user.comments.create(params_for_create)
    redirect_back_or_to(profile_path(params_for_create[:profile_id]))
  end

  private

  def params_for_create
    params.require(:comment).permit(:content, :profile_id)
  end
end
