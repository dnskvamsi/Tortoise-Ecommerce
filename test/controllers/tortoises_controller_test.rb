require "test_helper"

class TortoisesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:user_one)
    @tortoise = tortoises(:tortoise_one)
  end

  test "should get new if authenticated" do
    sign_in @user
    get new_tortoise_url
    assert_response :success
  end

  test "should get edit" do
    sign_in @user
    get edit_tortoise_url(@tortoise)
    assert_response :success
  end

  test "should update tortoise" do
    patch tortoise_path(@tortoise), params: { tortoise: { name: "Updated Name" } }
    assert_redirected_to tortoise_url(@tortoise)
  end

  test "should show tortoise" do
    get tortoise_url(@tortoise)
    assert_response :success
  end

  test "should redirect to browse listings if tortoise not found" do
    get tortoise_url(-1)
    assert_redirected_to browse_listings_path
    assert_equal "Tortoise not found.", flash[:alert]
  end

  test "should get related tortoises" do
    get related_tortoises_url, params: { current_tortoise_id: @tortoise.id }
    assert_response :success
    assert_template partial: "_related_tortoises"
    assert_not_includes assigns(:related_tortoises).map(&:id), @tortoise.id
  end

  test "should create tortoise if authenticated" do
    sign_in @user
    assert_difference("Tortoise.count", 1) do
      post tortoises_url, params: { tortoise: { name: "New Tortoise", species: "Testudo", price: 100 } }
    end
    assert_redirected_to root_path
  end

  test "should not create tortoise if unauthenticated" do
    assert_no_difference("Tortoise.count") do
      post tortoises_url, params: { tortoise: { name: "New Tortoise", species: "Testudo", price: 100 } }
    end
    assert_redirected_to new_user_session_url
  end

  private

  def sign_in(user)
    post user_session_path, params: { user: { email: user.email, password: 'password123' } }
  end

  def sign_out(user)
    delete destroy_user_session_path
  end
end
