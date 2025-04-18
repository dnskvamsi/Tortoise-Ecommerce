require "test_helper"

class FaqControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:user_one)
    @faq = faqs(:one)
    sign_in @user
  end

  test "should get index" do
    get faq_index_path
    assert_response :success
    assert_not_nil assigns(:faqs)
  end


  test "should create faq and redirect to index" do
    post '/faq', params: { faq: { question: "What is a tortoise?" } }

    assert_redirected_to faq_index_path
  end

  test "should not allow unauthenticated user to create FAQ" do
    sign_out @user

    assert_no_difference("Faq.count") do
      post '/faq', params: { faq: { question: "What is a tortoise?" } }
    end

    assert_redirected_to new_user_session_url
  end
end
