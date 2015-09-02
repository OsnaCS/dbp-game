require 'test_helper'

class StationtypesControllerTest < ActionController::TestCase
  setup do
    @stationtype = stationtypes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stationtypes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stationtype" do
    assert_difference('Stationtype.count') do
      post :create, stationtype: { costCristal: @stationtype.costCristal, costFuel: @stationtype.costFuel, costMineral: @stationtype.costMineral, name: @stationtype.name, statID: @stationtype.statID }
    end

    assert_redirected_to stationtype_path(assigns(:stationtype))
  end

  test "should show stationtype" do
    get :show, id: @stationtype
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stationtype
    assert_response :success
  end

  test "should update stationtype" do
    patch :update, id: @stationtype, stationtype: { costCristal: @stationtype.costCristal, costFuel: @stationtype.costFuel, costMineral: @stationtype.costMineral, name: @stationtype.name, statID: @stationtype.statID }
    assert_redirected_to stationtype_path(assigns(:stationtype))
  end

  test "should destroy stationtype" do
    assert_difference('Stationtype.count', -1) do
      delete :destroy, id: @stationtype
    end

    assert_redirected_to stationtypes_path
  end
end
