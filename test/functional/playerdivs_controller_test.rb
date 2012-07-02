require 'test_helper'

class PlayerdivsControllerTest < ActionController::TestCase
  setup do
    @playerdiv = playerdivs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:playerdivs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create playerdiv" do
    assert_difference('Playerdiv.count') do
      post :create, :playerdiv => { :division_id => @playerdiv.division_id, :player_id => @playerdiv.player_id }
    end

    assert_redirected_to playerdiv_path(assigns(:playerdiv))
  end

  test "should show playerdiv" do
    get :show, :id => @playerdiv
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @playerdiv
    assert_response :success
  end

  test "should update playerdiv" do
    put :update, :id => @playerdiv, :playerdiv => { :division_id => @playerdiv.division_id, :player_id => @playerdiv.player_id }
    assert_redirected_to playerdiv_path(assigns(:playerdiv))
  end

  test "should destroy playerdiv" do
    assert_difference('Playerdiv.count', -1) do
      delete :destroy, :id => @playerdiv
    end

    assert_redirected_to playerdivs_path
  end
end
