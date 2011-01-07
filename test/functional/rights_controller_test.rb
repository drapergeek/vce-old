require 'test_helper'

class RightsControllerTest < ActionController::TestCase
  
=begin
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rights)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rights" do
    assert_difference('Rights.count') do
      post :create, :rights => { }
    end

    assert_redirected_to rights_path(assigns(:rights))
  end

  test "should show rights" do
    get :show, :id => rights(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => rights(:one).id
    assert_response :success
  end

  test "should update rights" do
    put :update, :id => rights(:one).id, :rights => { }
    assert_redirected_to rights_path(assigns(:rights))
  end

  test "should destroy rights" do
    assert_difference('Rights.count', -1) do
      delete :destroy, :id => rights(:one).id
    end

    assert_redirected_to rights_path
  end
=end


end
