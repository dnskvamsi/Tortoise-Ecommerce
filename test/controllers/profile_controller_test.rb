require "test_helper"

class ProfileControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:user_one)
    @profile = profiles(:one)
    @profile_2= profiles(:two)
    sign_in @user
  end

  teardown do
    sign_out @user
  end


  test "should get new" do
    get new_profile_url
    assert_response :success
    assert_template :new
  end

  test "should create profile with valid params" do
    assert_difference("Profile.count", 1) do
      post '/profile', params: { profile: { title: "New Profile", description: "Description" } }
    end

    assert_redirected_to profile_index_path
  end

  test "should render new if profile creation fails" do
    Profile.any_instance.stubs(:save).returns(false)

    post '/profile', params: { profile: { title: "", description: "" } }
    assert_response :unprocessable_entity
  end

  test "should get edit" do
    get edit_profile_url(@profile)
    assert_response :success
  end

  test "should update profile" do
    patch profile_url(@profile), params: { profile: { title: "Updated Title" } }
    assert_redirected_to profile_path(@profile)
    assert_equal "Profile details updated successfully.", flash[:notice]
    @profile.reload
    assert_equal "Updated Title", @profile.title
  end

  test "should show profile" do
    @profile.image.attach(io: File.open("test/fixtures/files/box.png"), filename: "box.png")
    @profile.save

    get profile_url(@profile.id)
    assert_response :success
    assert_template :show
  end

  test "should get index" do
    @profile.image.attach(io: File.open("test/fixtures/files/box.png"), filename: "box.png")
    @profile_2.image.attach(io: File.open("test/fixtures/files/box.png"), filename: "box.png")

    get '/profile'
    assert_response :success
    assert_not_empty assigns(:profiles)
    assert_template :index
  end

  test "should redirect unauthenticated user from new" do
    sign_out @user
    get new_profile_url
    assert_redirected_to new_user_session_path
  end

  test "should redirect unauthenticated user from create" do
    sign_out @user
    assert_no_difference("Profile.count") do
      post '/profile', params: { profile: { title: "New Profile", description: "Description", image: "image_url.jpg" } }
    end
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
