require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:user_one) # Assuming a valid user fixture exists
    sign_in @user # Simulate user login
  end

  teardown do
    sign_out @user
  end

  test "should get account page" do
    get account_path
    assert_response :success
  end

  test "should update account information with valid data" do
    patch update_account_path, params: { user: { first_name: "Updated", last_name: "Name" } }
    assert_redirected_to account_path
    assert_equal "Account information updated successfully.", flash[:notice]
    assert_equal "Updated", @user.reload.first_name
  end

  test "should fail to update account information with invalid data" do
    patch update_account_path, params: { user: { email: "invalid_email" } }
    assert_response :unprocessable_entity
    assert_equal "Failed to update account information.", flash[:alert]
  end

  test "should fail to update account information with invalid data" do
    patch update_account_path, params: { user: { email: "invalid_email" } }, xhr: true
    assert_response :unprocessable_entity
    assert_equal "Failed to update account information.", flash[:alert]
  end

  test "should update payment details with valid data" do
    patch update_payment_details_path, params: { user: { card_holder_name: "New Holder", card_number: "1234567890123456", expiry_date: "12/25", cvv: "123" } }
    assert_redirected_to account_path
    assert_equal "Payment details updated successfully.", flash[:notice]
  end

  test "should fail to update payment details with invalid data" do
    User.any_instance.stubs(:update).returns(false)
    patch update_payment_details_path, params: { user: { card_holder_name: "New holder" } }
    assert_response :unprocessable_entity
    assert_equal "Failed to update payment details. Please check the errors.", flash[:alert]
  end

  test "should save a new address with valid data" do
    sign_in @user
    post users_save_address_path(@user), params: {
      address: {
        address_type: "Home",
        apartment_no: "123",
        street_address: "Main Street",
        city: "New York",
        state: "NY",
        pin_code: "100001"
      }
    }

    assert_redirected_to account_path
    follow_redirect!
  end


  test "should fail to save address with invalid data" do
    sign_in @user
    Address.define_method(:save) { false }

    post users_save_address_path(@user), params: {
      address: {
        address_type: "Home",
        apartment_no: "123",
        street_address: "Main Street",
        city: "New York",
        state: "NY",
        pin_code: "100001"
      }
    }

    assert_redirected_to account_path
  end


  private

  def sign_in(user)
    post user_session_path, params: { user: { email: user.email, password: 'password123' } }
  end

  def sign_out(user)
    delete destroy_user_session_path
  end
end
