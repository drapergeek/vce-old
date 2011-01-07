require File.dirname(__FILE__) + '/../test_helper'
require 'courses_controller'
require 'authenticated_test_helper'

# Re-raise errors caught by the controller.
class CoursesController; def rescue_action(e) raise e end; end

class CoursesControllerTest < Test::Unit::TestCase
  fixtures :courses, :users


=begin
  def setup
    @controller = CoursesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = courses(:one).id
    login_as :quentin
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:courses)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:course)
    assert assigns(:course).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:course)
  end

  def test_create
    assert login_as("quentin")
    num_courses = Course.count

    post :create, :course => {:name=>'Swimming'}

    assert_response :redirect
    assert_redirected_to :action => 'list'
    assert_equal num_courses + 1, Course.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:course)
    assert assigns(:course).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Course.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Course.find(@first_id)
    }
  end
=end

end
