require 'test_helper'

class CampersControllerTest < ActionController::TestCase

  test "can load the index page" do
    get :index
    assert_template "campers/list"
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
  
  test "can create a camper" do
    assert_difference 'Camper.all.count' do
      post :create, :camper=>Factory.attributes_for(:camper)
    end
    assert_redirected_to :action=>"show", :id=>assigns(:camper).id
  end

end
