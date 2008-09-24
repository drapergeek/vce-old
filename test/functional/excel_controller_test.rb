require File.dirname(__FILE__) + '/../test_helper'
require 'excel_controller'

# Re-raise errors caught by the controller.
class ExcelController; def rescue_action(e) raise e end; end

class ExcelControllerTest < Test::Unit::TestCase
  def setup
    @controller = ExcelController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
  
  def test_correct_receipt_with_1_camper
    
  end
end
