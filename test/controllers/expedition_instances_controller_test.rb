require 'test_helper'

class ExpeditionInstancesControllerTest < ActionController::TestCase
  setup do
    @expedition_instance = expedition_instances(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:expedition_instances)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create expedition_instance" do
    assert_difference('ExpeditionInstance.count') do
      post :create, expedition_instance: { expedition_id: @expedition_instance.expedition_id, user_id: @expedition_instance.user_id }
    end

    assert_redirected_to expedition_instance_path(assigns(:expedition_instance))
  end

  test "should show expedition_instance" do
    get :show, id: @expedition_instance
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @expedition_instance
    assert_response :success
  end

  test "should update expedition_instance" do
    patch :update, id: @expedition_instance, expedition_instance: { expedition_id: @expedition_instance.expedition_id, user_id: @expedition_instance.user_id }
    assert_redirected_to expedition_instance_path(assigns(:expedition_instance))
  end

  test "should destroy expedition_instance" do
    assert_difference('ExpeditionInstance.count', -1) do
      delete :destroy, id: @expedition_instance
    end

    assert_redirected_to expedition_instances_path
  end
end
