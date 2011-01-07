require 'test_helper'

class AnnoucementsControllerTest < ActionController::TestCase
  
=begin

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:annoucements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create annoucement" do
    assert_difference('Annoucement.count') do
      post :create, :annoucement => { }
    end

    assert_redirected_to annoucement_path(assigns(:annoucement))
  end

  test "should show annoucement" do
    get :show, :id => annoucements(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => annoucements(:one).id
    assert_response :success
  end

  test "should update annoucement" do
    put :update, :id => annoucements(:one).id, :annoucement => { }
    assert_redirected_to annoucement_path(assigns(:annoucement))
  end

  test "should destroy annoucement" do
    assert_difference('Annoucement.count', -1) do
      delete :destroy, :id => annoucements(:one).id
    end

    assert_redirected_to annoucements_path
  end
  
=end
end
