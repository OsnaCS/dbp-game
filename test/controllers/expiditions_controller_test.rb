require 'test_helper'

class ExpiditionsControllerTest < ActionController::TestCase
  setup do
    @expidition = expiditions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:expiditions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create expidition" do
    assert_difference('Expidition.count') do
      post :create, expidition: {  }
    end

    assert_redirected_to expidition_path(assigns(:expidition))
  end

  test "should show expidition" do
    get :show, id: @expidition
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @expidition
    assert_response :success
  end

  test "should update expidition" do
    patch :update, id: @expidition, expidition: {  }
    assert_redirected_to expidition_path(assigns(:expidition))
  end

  test "should destroy expidition" do
    assert_difference('Expidition.count', -1) do
      delete :destroy, id: @expidition
    end

    assert_redirected_to expiditions_path
  end
end
