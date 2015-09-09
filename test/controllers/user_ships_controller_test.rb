require 'test_helper'

class UserShipsControllerTest < ActionController::TestCase
  setup do
    @user_ship = user_ships(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_ships)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_ship" do
    assert_difference('UserShip.count') do
      post :create, user_ship: { ship_id: @user_ship.ship_id, user_id: @user_ship.user_id }
    end

    assert_redirected_to user_ship_path(assigns(:user_ship))
  end

  test "should show user_ship" do
    get :show, id: @user_ship
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_ship
    assert_response :success
  end

  test "should update user_ship" do
    patch :update, id: @user_ship, user_ship: { ship_id: @user_ship.ship_id, user_id: @user_ship.user_id }
    assert_redirected_to user_ship_path(assigns(:user_ship))
  end

  test "should destroy user_ship" do
    assert_difference('UserShip.count', -1) do
      delete :destroy, id: @user_ship
    end

    assert_redirected_to user_ships_path
  end
end
