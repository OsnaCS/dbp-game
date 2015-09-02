require 'test_helper'

class StationsInstancesControllerTest < ActionController::TestCase
  setup do
    @stations_instance = stations_instances(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stations_instances)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stations_instance" do
    assert_difference('StationsInstance.count') do
      post :create, stations_instance: { level: @stations_instance.level, shipID: @stations_instance.shipID, statID: @stations_instance.statID }
    end

    assert_redirected_to stations_instance_path(assigns(:stations_instance))
  end

  test "should show stations_instance" do
    get :show, id: @stations_instance
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stations_instance
    assert_response :success
  end

  test "should update stations_instance" do
    patch :update, id: @stations_instance, stations_instance: { level: @stations_instance.level, shipID: @stations_instance.shipID, statID: @stations_instance.statID }
    assert_redirected_to stations_instance_path(assigns(:stations_instance))
  end

  test "should destroy stations_instance" do
    assert_difference('StationsInstance.count', -1) do
      delete :destroy, id: @stations_instance
    end

    assert_redirected_to stations_instances_path
  end
end
