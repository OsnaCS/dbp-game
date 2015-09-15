require 'test_helper'

class UnitInstancesControllerTest < ActionController::TestCase
  setup do
    @unit_instance = unit_instances(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:unit_instances)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create unit_instance" do
    assert_difference('UnitInstance.count') do
      post :create, unit_instance: { amount: @unit_instance.amount, ship_id: @unit_instance.ship_id, unit_id: @unit_instance.unit_id }
    end

    assert_redirected_to unit_instance_path(assigns(:unit_instance))
  end

  test "should show unit_instance" do
    get :show, id: @unit_instance
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @unit_instance
    assert_response :success
  end

  test "should update unit_instance" do
    patch :update, id: @unit_instance, unit_instance: { amount: @unit_instance.amount, ship_id: @unit_instance.ship_id, unit_id: @unit_instance.unit_id }
    assert_redirected_to unit_instance_path(assigns(:unit_instance))
  end

  test "should destroy unit_instance" do
    assert_difference('UnitInstance.count', -1) do
      delete :destroy, id: @unit_instance
    end

    assert_redirected_to unit_instances_path
  end
end
