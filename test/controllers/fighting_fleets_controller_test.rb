require 'test_helper'

class FightingFleetsControllerTest < ActionController::TestCase
  setup do
    @fighting_fleet = fighting_fleets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fighting_fleets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fighting_fleet" do
    assert_difference('FightingFleet.count') do
      post :create, fighting_fleet: { shield: @fighting_fleet.shield, user_id: @fighting_fleet.user_id }
    end

    assert_redirected_to fighting_fleet_path(assigns(:fighting_fleet))
  end

  test "should show fighting_fleet" do
    get :show, id: @fighting_fleet
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fighting_fleet
    assert_response :success
  end

  test "should update fighting_fleet" do
    patch :update, id: @fighting_fleet, fighting_fleet: { shield: @fighting_fleet.shield, user_id: @fighting_fleet.user_id }
    assert_redirected_to fighting_fleet_path(assigns(:fighting_fleet))
  end

  test "should destroy fighting_fleet" do
    assert_difference('FightingFleet.count', -1) do
      delete :destroy, id: @fighting_fleet
    end

    assert_redirected_to fighting_fleets_path
  end
end
