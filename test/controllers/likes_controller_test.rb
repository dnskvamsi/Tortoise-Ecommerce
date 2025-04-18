require "test_helper"

class LikesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:user_two)
    @profile = profiles(:one)
    sign_in @user
  end

  test "should create a like and render turbo_stream for liked state" do
    sign_in @user

    assert_difference("Like.count", 1) do
      post like_path(@profile), xhr: true
    end

    assert_response :success
  end

  test "should not create duplicate likes" do
    sign_in @user

    @user.likes.create(profile: @profile)

    assert_no_difference("Like.count") do
      post like_path(@profile), xhr: true
    end

    assert_response :success
  end

  test "should destroy a like and render turbo_stream for unliked state" do
    sign_in @user
    @user.likes.create!(profile: @profile)

    assert_difference("Like.count", -1) do
      delete dislike_path(@profile), xhr: true
    end

    assert_response :success
  end

  test "should handle destroying a like that does not exist" do
    sign_in @user
    assert_no_difference("Like.count") do
      delete dislike_path(@profile), xhr: true
    end

    assert_response :success
  end

  test "should redirect unauthenticated users" do
    sign_out @user

    post like_path(@profile), xhr: true
    assert_response :unauthorized

    @like = profiles(:two)
    delete dislike_path(@profile), xhr: true
    assert_response :unauthorized
  end

  private

  def sign_in(user)
    post user_session_path, params: { user: { email: user.email, password: 'password123' } }
  end

  def sign_out(user)
    delete destroy_user_session_path
  end
end
