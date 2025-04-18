class AnswerController < ApplicationController
  before_action :authenticate_user!

  def create
    faq = Faq.find(params_for_create[:faq_id])
    answer = Answer.create(params_for_create)
    redirect_to faq_index_path
  end

  private
  def params_for_create
    params.require(:answer).permit(:content, :faq_id)
  end
end
