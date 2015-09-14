require 'test_helper'

class FacilityInstancesControllerTest < ActionController::TestCase
  setup do
    @facility_instance = facility_instances(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:facility_instances)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create facility_instance" do
    assert_difference('FacilityInstance.count') do
      post :create, facility_instance: { count: @facility_instance.count, create_count: @facility_instance.create_count, facility_id: @facility_instance.facility_id, ship_id: @facility_instance.ship_id, start_time: @facility_instance.start_time }
    end

    assert_redirected_to facility_instance_path(assigns(:facility_instance))
  end

  test "should show facility_instance" do
    get :show, id: @facility_instance
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @facility_instance
    assert_response :success
  end

  test "should update facility_instance" do
    patch :update, id: @facility_instance, facility_instance: { count: @facility_instance.count, create_count: @facility_instance.create_count, facility_id: @facility_instance.facility_id, ship_id: @facility_instance.ship_id, start_time: @facility_instance.start_time }
    assert_redirected_to facility_instance_path(assigns(:facility_instance))
  end

  test "should destroy facility_instance" do
    assert_difference('FacilityInstance.count', -1) do
      delete :destroy, id: @facility_instance
    end

    assert_redirected_to facility_instances_path
  end
end
