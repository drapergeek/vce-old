require 'test_helper'

class CampersControllerTest < ActionController::TestCase

  setup do
    login
  end

  test "can load the index page" do
    get :index
    assert_template "index"
  end
  
  test "new page" do
    get :new
    assert_template :new
  end
  
  test "posting nothing redirects back to new" do
    post :create
    assert_response :success
    assert_template :new
  end
  test "show with a number loads a new camper if not found" do
    get :show, :number=>"B002", :name=>"Steven Draper", :payment=>"123123123"
    assert_redirected_to :action=>"new", :number=>"B002", :name=>"Steven Draper", :payment=>"123123123"
    assert_equal flash[:notice],"This camper has not yet been created"
    
  end
  
  test "can create a camper" do
    assert_difference 'Camper.all.count' do
      post :create, :camper=>Factory.attributes_for(:camper)
    end
    assert_redirected_to :action=>"show", :id=>assigns(:camper).id
  end
  
  test "can load the edit page" do
    c = Factory.build(:camper)
    assert c.save, "The standard camper can't be saved"
    get :edit, :id=>c.id
    assert_response :success
    assert_template :edit
  end
  
  test "can update a camper" do
    c = Factory.build(:camper)
    assert c.save, "The standard camper can't be saved"
    put :update, :id=>c.id, :camper=>Factory.attributes_for(:camper, :fname=>"Jason")
    assert_redirected_to(assigns(:camper))
  end
  
  test "can destory a camper" do
    c = Factory.build(:camper)
    assert c.save, "The standard camper can't be saved"
    assert_difference('Camper.count', -1) do
      delete :destroy, :id => Camper.first
    end
    assert_equal flash[:notice], 'The camper was deleted successfully.'
    assert_redirected_to campers_path
  end

end
