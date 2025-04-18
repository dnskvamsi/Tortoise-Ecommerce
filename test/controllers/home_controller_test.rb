require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @user = users(:user_one)
    @admin = users(:admin)
    @vendor = users(:vendor)
    @tortoise = tortoises(:tortoise_one)
    @accessory = accessories(:accessory_one)
    sign_in @user
  end

  teardown do
    sign_out @user
  end

  test "should get show for customer" do
    sign_out @user
    customer = @user.update(role: :customer)
    sign_in @user
    get root_path
    assert_response :success
    assert_template :show
  end

  test "should get show for non-logged in users" do
    sign_out @user
    get root_path
    assert_response :success
    assert_template :show
  end

  test "should get customer executive page for customer executive" do
    sign_out @user
    @user.update(role: :customer_executive)
    sign_in @user
    get root_path
    assert_response :success
    assert_template :customer_executive
  end

  test "should render role-specific view for admin" do
    sign_in @admin
    get root_path
    assert_response :success
    assert_template :admin
  end

  test "should render role-specific view for vendor" do
    sign_out @user
    @vendor.update!(role: :vendor)
    puts(@vendor.role)
    sign_in @vendor
    get root_path
    assert_response :success
    assert_template :vendor
  end

  test "should get browse_listings with all items" do
    get browse_listings_path
    assert_response :success
    assert_not_nil assigns(:tortoises)
    assert_not_nil assigns(:accessories)
  end

  test "should filter browse_listings items" do
    get browse_listings_path, params: { filter: { species: 'Galapagos' } }
    assert_response :success
    assert assigns(:tortoises).all? { |t| t.species == 'Galapagos' }
  end

  test "should calculate sales for logged-in user" do
    sign_in @vendor
    get sales_path
    assert_response :success
    assert_not_nil assigns(:total_inventory_amount)
    assert_not_nil assigns(:sold_price_amount)
    assert_not_nil assigns(:in_transit_amount)
  end

  test "should redirect sales when not logged in" do
    sign_out @user
    get sales_path
    assert_redirected_to new_user_session_path
  end

  private

  def sign_in(user)
    post user_session_path, params: { user: { email: user.email, password: 'password123' } }
  end

  def sign_out(user)
    delete destroy_user_session_path
  end
end
