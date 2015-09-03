require 'test_helper'

class ScienceInstancesControllerTest < ActionController::TestCase
  setup do
    @science_instance = science_instances(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:science_instances)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create science_instance" do
    assert_difference('ScienceInstance.count') do
      post :create, science_instance: { level: @science_instance.level, science_id: @science_instance.science_id, user_id: @science_instance.user_id }
    end

    assert_redirected_to science_instance_path(assigns(:science_instance))
  end

  test "should show science_instance" do
    get :show, id: @science_instance
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @science_instance
    assert_response :success
  end

  test "should update science_instance" do
    patch :update, id: @science_instance, science_instance: { level: @science_instance.level, science_id: @science_instance.science_id, user_id: @science_instance.user_id }
    assert_redirected_to science_instance_path(assigns(:science_instance))
  end

  test "should destroy science_instance" do
    assert_difference('ScienceInstance.count', -1) do
      delete :destroy, id: @science_instance
    end

    assert_redirected_to science_instances_path
  end
end
