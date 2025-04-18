require "test_helper"

class FollowsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:user_one)
    @profile = profiles(:one)
    sign_in @user
  end


  test "should create a follow and render turbo_stream for following state" do
    assert_difference("Follow.count", 1) do
      post follow_path(@profile), xhr: true
    end

    assert_response :success
  end

  test "should not create duplicate follows" do
    @user.follows.create(profile: @profile)

    assert_no_difference("Follow.count") do
      post follow_path(@profile), xhr: true
    end

    assert_response :success
  end

  test "should destroy a follow and render turbo_stream for not-following state" do
    @follow = @user.follows.create(profile: @profile)

    assert_difference("Follow.count", -1) do
      delete unfollow_path(@profile), xhr: true
    end

    assert_response :success
  end

  test "should handle destroying a follow that does not exist" do
    assert_no_difference("Follow.count") do
      delete unfollow_path(@profile), xhr: true
    end

    assert_response :success
  end

  test "should return unauthorized when unauthenticated for create" do
    sign_out @user

    post follow_path(@profile), xhr: true
    assert_response :unauthorized
  end

  test "should return unauthorized when unauthenticated for destroy" do
    sign_out @user

    delete unfollow_path(@profile), xhr: true
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
