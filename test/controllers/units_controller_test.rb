require 'test_helper'

class UnitsControllerTest < ActionController::TestCase
  setup do
    @unit = units(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:units)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create unit" do
    assert_difference('Unit.count') do
      post :create, unit: { cargo: @unit.cargo, crystal_price: @unit.crystal_price, damage: @unit.damage, damage_type_id: @unit.damage_type_id, fuel_price: @unit.fuel_price, metal_price: @unit.metal_price, name: @unit.name, research_requiement_two: @unit.research_requiement_two, research_requirement_one: @unit.research_requirement_one, shell: @unit.shell, shipyard_requirement: @unit.shipyard_requirement, speed: @unit.speed, total_cost: @unit.total_cost }
    end

    assert_redirected_to unit_path(assigns(:unit))
  end

  test "should show unit" do
    get :show, id: @unit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @unit
    assert_response :success
  end

  test "should update unit" do
    patch :update, id: @unit, unit: { cargo: @unit.cargo, crystal_price: @unit.crystal_price, damage: @unit.damage, damage_type_id: @unit.damage_type_id, fuel_price: @unit.fuel_price, metal_price: @unit.metal_price, name: @unit.name, research_requiement_two: @unit.research_requiement_two, research_requirement_one: @unit.research_requirement_one, shell: @unit.shell, shipyard_requirement: @unit.shipyard_requirement, speed: @unit.speed, total_cost: @unit.total_cost }
    assert_redirected_to unit_path(assigns(:unit))
  end

  test "should destroy unit" do
    assert_difference('Unit.count', -1) do
      delete :destroy, id: @unit
    end

    assert_redirected_to units_path
  end
end
