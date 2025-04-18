require "test_helper"

class ChatSessionControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:user_one)
    @chat_session = ChatSession.last || ChatSession.create
    sign_in @user
  end

  test "should create a chat session and redirect to chat session show page" do
    assert_difference("ChatSession.count", 1) do
      assert_difference("ChatParticipation.count", 1) do
        post '/chat_session'
      end
    end

    assert_redirected_to chat_session_path(ChatSession.last)
  end

  test "should add a participant to a chat session and redirect to chat session show page" do
    assert_difference("ChatParticipation.count", 1) do
      post add_participant_path, params: { chat_session_id: @chat_session.id }
    end

    assert_redirected_to chat_session_path(@chat_session)
  end

  test "should show chat session" do
    get chat_session_path(@chat_session)
    assert_response :success
    assert_equal @chat_session, assigns(:chat_session)
  end

  test "should get index and list user's chat sessions" do
    get chat_session_index_path
    assert_response :success
    assert_equal @user.chat_sessions.order(:created_at), assigns(:chat_sessions)
  end

  test "should not allow unauthenticated user to create a chat session" do
    sign_out @user

    assert_no_difference("ChatSession.count") do
       post '/chat_session'
    end

    assert_redirected_to new_user_session_url
  end
end
