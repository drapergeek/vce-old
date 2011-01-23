require 'test_helper'
class ReceiptsControllerTest < ActionController::TestCase

  test "cant load without a login" do
    get :index
    assert_redirected_to :root
  end
  
  test "can load index with a login" do
    
  end
  
end
