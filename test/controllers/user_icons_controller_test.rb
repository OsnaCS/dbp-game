require 'test_helper'

class UserIconsControllerTest < ActionController::TestCase
  setup do
    @user_icon = user_icons(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_icons)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_icon" do
    assert_difference('UserIcon.count') do
      post :create, user_icon: { user_id: @user_icon.user_id }
    end

    assert_redirected_to user_icon_path(assigns(:user_icon))
  end

  test "should show user_icon" do
    get :show, id: @user_icon
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_icon
    assert_response :success
  end

  test "should update user_icon" do
    patch :update, id: @user_icon, user_icon: { user_id: @user_icon.user_id }
    assert_redirected_to user_icon_path(assigns(:user_icon))
  end

  test "should destroy user_icon" do
    assert_difference('UserIcon.count', -1) do
      delete :destroy, id: @user_icon
    end

    assert_redirected_to user_icons_path
  end
end
