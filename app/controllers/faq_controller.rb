class FaqController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    @faq = Faq.create(params_for_create.merge(user: current_user))
    redirect_to faq_index_path
  end

  def index
    @faqs = Faq.includes(:answers).order(:created_at).all
  end

  private

  def params_for_create
    params.require(:faq).permit(:question)
  end
end
