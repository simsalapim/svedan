require 'test_helper'

class OrdsControllerTest < ActionController::TestCase
  setup do
    @ord = ords(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ords)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ord" do
    assert_difference('Ord.count') do
      post :create, ord: { english: @ord.english, failure_count: @ord.failure_count, show_count: @ord.show_count, shown_at: @ord.shown_at, swedish: @ord.swedish }
    end

    assert_redirected_to ord_path(assigns(:ord))
  end

  test "should show ord" do
    get :show, id: @ord
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ord
    assert_response :success
  end

  test "should update ord" do
    patch :update, id: @ord, ord: { english: @ord.english, failure_count: @ord.failure_count, show_count: @ord.show_count, shown_at: @ord.shown_at, swedish: @ord.swedish }
    assert_redirected_to ord_path(assigns(:ord))
  end

  test "should destroy ord" do
    assert_difference('Ord.count', -1) do
      delete :destroy, id: @ord
    end

    assert_redirected_to ords_path
  end
end
