require "test_helper"

class CommentControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:user_one)
    @profile = profiles(:one)
    @profile.image.attach(io: File.open("test/fixtures/files/box.png"), filename: "box.png")
    @profile.save
    sign_in @user
  end

  test "should create a comment and redirect to profile page" do
    assert_difference("Comment.count", 1) do
      post '/comment/create', params: { comment: { content: "Nice profile!", profile_id: @profile.id } }
    end

    assert_redirected_to profile_path(@profile)
  end


  test "should not allow unauthenticated user to create a comment" do
    sign_out @user

    assert_no_difference("Comment.count") do
      post '/comment/create', params: { comment: { content: "Nice profile!", profile_id: @profile.id } }
    end

    assert_redirected_to new_user_session_url
  end
end
