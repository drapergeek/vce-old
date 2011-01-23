require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  
  test "should load login page" do
    get :index
    assert_template 'index'
  end


end
