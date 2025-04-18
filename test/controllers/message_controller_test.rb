require "test_helper"

class MessageControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:user_one)
    @chat_session = ChatSession.create
    sign_in @user
  end

  test "should create a message and redirect to chat session index" do
    assert_difference("Message.count", 1) do
      post '/message/create', params: { message: { content: "Hello!", chat_session_id: @chat_session.id } }
    end

    assert_redirected_to chat_session_index_url
  end

  test "should not allow unauthenticated user to create a message" do
    sign_out @user

    assert_no_difference("Message.count") do
      post '/message/create', params: { message: { content: "Hello!", chat_session_id: @chat_session.id } }
    end

    assert_redirected_to new_user_session_url
  end
end
