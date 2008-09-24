require File.dirname(__FILE__) + '/../test_helper'

class ReceiptTest < Test::Unit::TestCase
  fixtures :receipts

  # Replace this with your real tests.
  def test_truth
    assert true
  end
  
  def test_incorrect_receipt
    r = Receipt.new
    assert ! r.valid?
  end
    

end
