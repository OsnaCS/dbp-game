require 'test_helper'

class DamageTypesControllerTest < ActionController::TestCase
  setup do
    @damage_type = damage_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:damage_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create damage_type" do
    assert_difference('DamageType.count') do
      post :create, damage_type: { name: @damage_type.name, plattform_mult: @damage_type.plattform_mult, shell_mult: @damage_type.shell_mult, shield_mult: @damage_type.shield_mult, station_mult: @damage_type.station_mult }
    end

    assert_redirected_to damage_type_path(assigns(:damage_type))
  end

  test "should show damage_type" do
    get :show, id: @damage_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @damage_type
    assert_response :success
  end

  test "should update damage_type" do
    patch :update, id: @damage_type, damage_type: { name: @damage_type.name, plattform_mult: @damage_type.plattform_mult, shell_mult: @damage_type.shell_mult, shield_mult: @damage_type.shield_mult, station_mult: @damage_type.station_mult }
    assert_redirected_to damage_type_path(assigns(:damage_type))
  end

  test "should destroy damage_type" do
    assert_difference('DamageType.count', -1) do
      delete :destroy, id: @damage_type
    end

    assert_redirected_to damage_types_path
  end
end
