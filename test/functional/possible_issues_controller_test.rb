require 'test_helper'

class PossibleIssuesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => PossibleIssue.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    PossibleIssue.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    PossibleIssue.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to possible_issue_url(assigns(:possible_issue))
  end
  
  def test_edit
    get :edit, :id => PossibleIssue.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    PossibleIssue.any_instance.stubs(:valid?).returns(false)
    put :update, :id => PossibleIssue.first
    assert_template 'edit'
  end
  
  def test_update_valid
    PossibleIssue.any_instance.stubs(:valid?).returns(true)
    put :update, :id => PossibleIssue.first
    assert_redirected_to possible_issue_url(assigns(:possible_issue))
  end
  
  def test_destroy
    possible_issue = PossibleIssue.first
    delete :destroy, :id => possible_issue
    assert_redirected_to possible_issues_url
    assert !PossibleIssue.exists?(possible_issue.id)
  end
end
