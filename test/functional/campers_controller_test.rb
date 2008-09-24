require File.dirname(__FILE__) + '/../test_helper'
require 'campers_controller'

# Re-raise errors caught by the controller.
class CampersController; def rescue_action(e) raise e end; end

class CampersControllerTest < Test::Unit::TestCase
  fixtures :campers, :users, :courses

  def setup
    @controller = CampersController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @camper = campers(:one)
    @first_id = campers(:one).id
    login_as :quentin
    
  end
  
  def test_find
    #find with correct number
    post :find, :number=>'G001'
    assert_redirected_to :action=>'show', :id=>2    
    #find with not createid camper
    post :find, :number=>'G011'
    assert_redirected_to :action=>'new'
  end
  
  

  def test_index
    get :index
    assert_response :success
    assert_template 'list'
  end
  


  
  def test_search
    #test to search by camper id
    search_test('G001', 'Camper id')
    #test to search by names
    search_test("Jane", "fname")
    search_test("Lynn", 'mname')
    search_test("Doe", "lname")
    search_test("Lynn", "pref_name")
    #search by phone
    search_test("2221114444", "phone1")
  end

  def search_test(search, type)
    post :search, :search=>search
    assert_response :success, "Failed on " + type
    assert_template 'search', "Failed on " + type
    assert !assigns(:campers).blank?, "Failed on " + type
  end
  
  def test_search_with_no_found_campers
    post :search, :search=>'G011'
    assert_response :success
    assert_template 'search'
    assert assigns(:campers).blank?
  end
  
  def test_add_course
    course_count = Camper.find_by_id(1).courses.count
    post :add_course, :id=>1, :course_selection=>1
    assert_equal assigns(:camper).courses.count, course_count+1
    assert_redirected_to :action=>'show', :id=>1
  end
  
  def test_add_course_without_course_id 
    course_count = Camper.find_by_id(1).courses.count
    post :add_course, :id=>1
    assert_equal assigns(:camper).courses.count, course_count
    assert_redirected_to :action=>'show', :id=>1
  end

  def test_list
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:campers)
  end

  def test_show
    
    get :show, :id => @first_id
    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:camper)
    assert assigns(:camper).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:camper)
  end

  def test_create
    num_campers = Camper.count
    post :create, :camper => {:fname=>'Jason', :mname=>'Jason', :lname=>'Draper', :pref_name=>'Draper', :zip=>41121, :position=>0, :gender=>0, :number=>'B545'}
    assert_response :redirect
    assert_equal num_campers + 1, Camper.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:camper)
    assert assigns(:camper).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Camper.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Camper.find(@first_id)
    }
  end
end
