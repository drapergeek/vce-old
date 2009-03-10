require File.dirname(__FILE__) + '/../test_helper'
require 'receipts_controller'

# Re-raise errors caught by the controller.
class ReceiptsController; def rescue_action(e) raise e end; end

class ReceiptsControllerTest < Test::Unit::TestCase
  fixtures :receipts, :users
=begin
  def setup
    @controller = ReceiptsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = receipts(:one).id
   # login_as :quentin
  end
  
  def test_index_without_user_should_redirect
    get :index
    assert_redirected_to :action => "index" 
  end
  
  
begin
  def test_index
    setup
    get :index
    assert_response :success
    assert_template 'index'
    assert_not_nil assigns(:receipts)
  end
  

  def test_totals
    get :totals
    assert_response :success
    assert_template 'totals'
  
  end
  

  #Testing the search function
  def test_search
    #test to search by camper id
    search_test('Static', 'lname')
    #test to search by names
    search_test("Bob", "fname")
    search_test("StevenStatic", 'camper1')
    #search by phone
    search_test("2222222222", "phone1")
  end

  def search_test(search, type)
    post :search, :search=>search
    assert_response :success, "Failed on " + type
    assert_template 'search', "Failed on " + type
    assert !assigns(:receipts).blank?, "Failed on " + type
  end
  
  def test_search_with_no_found_receipts
    post :search, :search=>'G011'
    assert_response :success
    assert_template 'index'
    assert assigns(:receipts).blank?
  end
  #end of search testing

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:receipt)
    assert assigns(:receipt).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:receipt)
  end

  def test_create
        
    num_receipts = Receipt.count

    post :create, :receipt => {:lname=>'Draper', :fname=>'Jason',  :date=>Date.today, :payment_method=>1, :amount=>185.00, :camper1=>'Frappy', :camper1_id=>'B003', :phone=>'276-252-6945'}

    assert_response :redirect
    assert_redirected_to :action => 'show'

    assert_equal num_receipts + 1, Receipt.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:receipt)
    assert assigns(:receipt).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    
    assert_nothing_raised {
      Receipt.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'index'

    assert_raise(ActiveRecord::RecordNotFound) {
      Receipt.find(@first_id)
    }
  end
  
  
  def test_list_by_date
    post :list_by_date :date=>
    date = params[:date]
    @receipts = Receipt.find(:all, :conditions => [ "date LIKE ?", "%#{date}%"])
    render :action=>'search'
  end
  
  def test_show_by_date
    @date = params[:date]
    @receipts = Receipt.find(:all, :conditions => [ "date LIKE ?", "%#{params[:date]}%"])
  end
=end

  
end
