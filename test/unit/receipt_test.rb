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
  
  
  def test_proper_camper_ids
    camper_id_testing("PG123", true)
    camper_id_testing("SG123", true)
  end
  
  def test_wrong_camper_ids
    camper_id_testing("X123", false)
    camper_id_testing("B1231", false)
    camper_id_testing("G13", false)
    camper_id_testing("13BG131",false)
  end
  
  def camper_id_testing(camper_id, valid)
     r = Receipt.new(:fname=>"Jason", 
                      :lname=>"Draper",
                      :address=>"117 Andra Dr", 
                      :city=>"Ridgeway",
                      :state=>"0", 
                      :zip=>"13311",
                      :amount=>"210",
                      :phone=>"111-222-2222",
                      :payment_method=>1,
                      :payment_extra=>1,
                      :camper1=>"Sally Draper",
                      :camper1_id=>camper_id )
      if valid==true
        assert r.valid?
      else
        assert !r.valid?
        assert r.errors.invalid?(:camper1_id)
      end
  end

end
