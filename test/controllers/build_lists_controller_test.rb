require 'test_helper'

class BuildListsControllerTest < ActionController::TestCase
  setup do
    @build_list = build_lists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:build_lists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create build_list" do
    assert_difference('BuildList.count') do
      post :create, build_list: {  }
    end

    assert_redirected_to build_list_path(assigns(:build_list))
  end

  test "should show build_list" do
    get :show, id: @build_list
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @build_list
    assert_response :success
  end

  test "should update build_list" do
    patch :update, id: @build_list, build_list: {  }
    assert_redirected_to build_list_path(assigns(:build_list))
  end

  test "should destroy build_list" do
    assert_difference('BuildList.count', -1) do
      delete :destroy, id: @build_list
    end

    assert_redirected_to build_lists_path
  end
end
