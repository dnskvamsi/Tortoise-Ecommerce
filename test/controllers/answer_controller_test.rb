require "test_helper"

class AnswerControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:user_one)
    @faq = faqs(:one)
    sign_in @user
  end

  test "should create an answer and redirect to FAQ index" do
    assert_difference("Answer.count", 1) do
      post '/answer', params: { answer: { content: "This is an answer", faq_id: @faq.id } }
    end

    assert_redirected_to faq_index_url
  end

  test "should not allow unauthenticated user to create an answer" do
    sign_out @user

    assert_no_difference("Answer.count") do
      post '/answer', params: { answer: { content: "This is an answer", faq_id: @faq.id } }
    end


    assert_redirected_to new_user_session_url
  end

  test "should not create an answer for a non-existent FAQ" do
    assert_raises(ActiveRecord::RecordNotFound) do
      post '/answer', params: { answer: { content: "This is an answer", faq_id: -1 } }
    end
  end
end
