require 'test_helper'
class ReceiptsControllerTest < ActionController::TestCase
  fixtures 'receipts'
  setup do
    login
  end
  
  test "can load index with a login" do
    get :index
    assert_template :index
  end
  
  test "can load new receipts page" do
    get :new
    assert_template :new
  end
  
  test "can create receipt" do
    assert_difference('Receipt.count') do
       post :create, :receipt => Factory.attributes_for(:receipt)
    end
    assert_redirected_to receipt_path(assigns(:receipt))
    assert_equal flash[:notice], "Receipt was successfully created."
  end
  
  test "can create a receipt without issues" do
    #don't know how to do this?
    assert true
  end
  
  test "can show a receipt" do
    get :show, :id=>Receipt.first
    assert_template :show
  end
  
  
  test "can edit a receipt" do
    r = Factory.build(:receipt)
    assert r.save
    get :edit, :id=>r.id
  end
  
  test "can update a receipt" do
    r = Factory.create(:receipt)
    post :update,:id=>r.id, :receipt=>Factory.attributes_for(:receipt, :id=>r.id, :lname=>"Steven")
    assert_redirected_to r
    assert_equal flash[:notice], "Receipt was successfully updated."
  end
  
  test "can load the totals page" do
    get :totals
    assert_template :totals
  end
  
  test "can destroy a receipt" do
    assert_difference('Receipt.count', -1) do
      delete :destroy, :id => Receipt.first.id
    end

    assert_redirected_to receipts_path
    assert_equal flash[:notice], "Your receipt has been successfully deleted."
  end
  
  
end
