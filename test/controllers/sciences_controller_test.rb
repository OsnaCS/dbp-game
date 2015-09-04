require 'test_helper'

class SciencesControllerTest < ActionController::TestCase
  setup do
    @science = sciences(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sciences)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create science" do
    assert_difference('Science.count') do
      post :create, science: { condition: @science.condition, cost1: @science.cost1, cost2: @science.cost2, cost3: @science.cost3, duration: @science.duration, factor: @science.factor, science_id: @science.science_id }
    end

    assert_redirected_to science_path(assigns(:science))
  end

  test "should show science" do
    get :show, id: @science
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @science
    assert_response :success
  end

  test "should update science" do
    patch :update, id: @science, science: { condition: @science.condition, cost1: @science.cost1, cost2: @science.cost2, cost3: @science.cost3, duration: @science.duration, factor: @science.factor, science_id: @science.science_id }
    assert_redirected_to science_path(assigns(:science))
  end

  test "should destroy science" do
    assert_difference('Science.count', -1) do
      delete :destroy, id: @science
    end

    assert_redirected_to sciences_path
  end
end
