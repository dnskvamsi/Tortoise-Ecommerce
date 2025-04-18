require "test_helper"

class ReviewsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:user_one)
    @tortoise = tortoises(:tortoise_one)
    sign_in @user
  end

  test "should get new" do
    get new_review_url
    assert_response :success
    assert_template :new
  end

  test "should create review and render turbo_stream" do
    assert_difference("Review.count", 1) do
      post reviews_url, params: {
        review: {
          comment: "This is a great tortoise!",
          tortoise_id: @tortoise.id,
          rating: 5
        }
      }, xhr: true
    end

    assert_response :success
  end

  test "should return unauthorized when unauthenticated for create" do
    sign_out @user

    post reviews_url, params: {
      review: {
        comment: "This is a great tortoise!",
        tortoise_id: @tortoise.id,
        rating: 5
      }
    }, xhr: true

    assert_response :unauthorized
  end
end
