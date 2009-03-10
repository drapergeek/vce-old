require File.dirname(__FILE__) + '/../test_helper'
require 'packs_controller'

# Re-raise errors caught by the controller.
class PacksController; def rescue_action(e) raise e end; end

class PacksControllerTest < Test::Unit::TestCase
  fixtures :packs, :users
=begin
  def setup
    @controller = PacksController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = packs(:one).id
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

    assert_not_nil assigns(:packs)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:pack)
    assert assigns(:pack).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:pack)
  end

  def test_create
    num_packs = Pack.count
    post :create, :pack => {}
    assert_response :redirect
    assert_redirected_to :action => 'list'
    assert_equal num_packs + 1, Pack.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:pack)
    assert assigns(:pack).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Pack.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Pack.find(@first_id)
    }
  end
=end


end
