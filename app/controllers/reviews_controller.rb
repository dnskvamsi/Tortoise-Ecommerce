class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
    review = Review.create(review_params.merge(user: current_user))
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("item_#{review.tortoise_id}", partial: 'shared/review', locals: { review: review})
      end
    end
  end

  private

  def review_params
    params.require(:review).permit(:comment, :tortoise_id, :rating)
  end
end
