require "test_helper"

class AccessoryControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:user_one)
    @accessory = accessories(:accessory_one)
    sign_in @user
  end

  test "should get new" do
    get new_accessory_url
    assert_response :success
  end

  test "should get edit" do
    get edit_accessory_url(@accessory)
    assert_response :success

  end


  test "should create accessory" do
    assert_difference("Accessory.count", 1) do
      post '/accessory', params: { accessory: { name: "New Accessory", gender: "Unisex", price: 100, quantity: 10 } }
    end
    assert_redirected_to root_path
    assert_equal "Accessory successfully created", flash[:notice]
  end


  test "should update accessory" do
    patch accessory_url(@accessory), params: { accessory: { name: "Updated Name" } }
    assert_redirected_to root_path
    assert_equal "Accessory updated successfully", flash[:notice]
    @accessory.reload
    assert_equal "Updated Name", @accessory.name
  end


  test "should show accessory" do
    get accessory_url(@accessory)
    assert_response :success
  end

  test "should redirect unauthenticated user from new" do
    sign_out @user
    get new_accessory_url
    assert_redirected_to new_user_session_path
  end

  test "should redirect unauthenticated user from create" do
    sign_out @user
    assert_no_difference("Accessory.count") do
      post '/accessory', params: { accessory: { name: "New Accessory", gender: "Unisex", price: 100, quantity: 10 } }
    end
    assert_redirected_to new_user_session_path
  end
end
