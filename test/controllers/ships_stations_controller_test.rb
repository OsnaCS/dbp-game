require 'test_helper'

class ShipsStationsControllerTest < ActionController::TestCase
  setup do
    @ships_station = ships_stations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ships_stations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ships_station" do
    assert_difference('ShipsStation.count') do
      post :create, ships_station: { level: @ships_station.level, ships_id: @ships_station.ships_id, stations_id: @ships_station.stations_id }
    end

    assert_redirected_to ships_station_path(assigns(:ships_station))
  end

  test "should show ships_station" do
    get :show, id: @ships_station
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ships_station
    assert_response :success
  end

  test "should update ships_station" do
    patch :update, id: @ships_station, ships_station: { level: @ships_station.level, ships_id: @ships_station.ships_id, stations_id: @ships_station.stations_id }
    assert_redirected_to ships_station_path(assigns(:ships_station))
  end

  test "should destroy ships_station" do
    assert_difference('ShipsStation.count', -1) do
      delete :destroy, id: @ships_station
    end

    assert_redirected_to ships_stations_path
  end
end
