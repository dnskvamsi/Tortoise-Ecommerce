require "test_helper"

class SupportControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:user_one)
    @chat_session = ChatSession.create!
    ChatParticipation.create!(user: @user, chat_session: @chat_session)
    sign_in @user
  end

  test "should get index" do
    get support_index_url
    assert_response :success
  end

  test "should not allow unauthenticated user to access index" do
    sign_out @user

    get support_index_url
    assert_redirected_to new_user_session_url
  end
end
