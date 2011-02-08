require 'test_helper'

class BusesControllerTest < ActionController::TestCase
  
  test "can load index page" do
    get :index
    assert :success
    assert_template 'index'
  end
  
  test "can load the new page" do
    get :new
    assert :success
    assert_template 'new'
  end
  
  test "can create a bus" do
    assert_difference 'Bus.all.count' do
      post :create, :bus=>Factory.attributes_for(:bus)
    end
    assert_redirected_to buses_path
    assert_equal flash[:notice], "Bus was successfully created."
  end
  
  test "can edit a bus" do
    Factory.create(:bus)
    get :edit, :id=>Bus.first
    assert :success
    assert_template "edit"
  end
  
  test "can update a bus" do
    b = Factory.create(:bus)
    post :update, :id=>b.id, :bus=>Factory.attributes_for(:bus,:name=>"HCS Bus 12")
    assert :success
    assert_redirected_to b
  end
  
  
  test "can destroy a bus" do
    b = Factory.build(:bus)
    assert b.save, "The standard bus can't be saved"
    assert_difference('Bus.all.count', -1) do
      delete :destroy, :id => Bus.first
    end
    assert_equal flash[:notice], "Bus was succesfully deleted"
    assert_redirected_to buses_path
  end
  
  
end