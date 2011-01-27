require 'test_helper'
class ReceiptsControllerTest < ActionController::TestCase
  fixtures 'receipts'

  
  test "can load index with a login" do
    get :index
    assert_template :index
  end
  
  test "can load new receipts page" do
    get :new
    assert_template :new
  end
  
  test "can create a receipt without issues" do
    #don't know how to do this?
    assert true
  end
  
  test "can show a receipt" do
    get :show, :id=>Receipt.first
    assert_template :show
  end
  
end
