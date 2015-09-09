require 'test_helper'

class ShipGroupsControllerTest < ActionController::TestCase
  setup do
    @ship_group = ship_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ship_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ship_group" do
    assert_difference('ShipGroup.count') do
      post :create, ship_group: { fleet_id: @ship_group.fleet_id, group_hitpoints: @ship_group.group_hitpoints, number: @ship_group.number, ship_id: @ship_group.ship_id }
    end

    assert_redirected_to ship_group_path(assigns(:ship_group))
  end

  test "should show ship_group" do
    get :show, id: @ship_group
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ship_group
    assert_response :success
  end

  test "should update ship_group" do
    patch :update, id: @ship_group, ship_group: { fleet_id: @ship_group.fleet_id, group_hitpoints: @ship_group.group_hitpoints, number: @ship_group.number, ship_id: @ship_group.ship_id }
    assert_redirected_to ship_group_path(assigns(:ship_group))
  end

  test "should destroy ship_group" do
    assert_difference('ShipGroup.count', -1) do
      delete :destroy, id: @ship_group
    end

    assert_redirected_to ship_groups_path
  end
end
