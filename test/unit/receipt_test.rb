require File.dirname(__FILE__) + '/../test_helper'

class ReceiptTest < Test::Unit::TestCase
  fixtures :receipts



  def test_empty_receipt
    r = Receipt.new
    assert ! r.valid?
    assert r.errors.invalid?(:lname), "The last name is not being required"
    assert r.errors.invalid?(:fname) , "The first name is not being required"
    assert r.errors.invalid?(:payment_method) , "The payment method is not being required"
    assert r.errors.invalid?(:camper1) , "The camper1 is not being required"
    assert r.errors.invalid?(:camper1_id) , "The camper1_id is not being required"
    assert r.errors.invalid?(:amount) , "The amount is not being required"
  end
  
  def generate_random_string(length, set="all")
    chars=""
    if set == "numbers"
      chars = "123456789"
    elsif set =="charsnumbers"      
      chars = "abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNOPQRSTUVWXYZ123456789"
    else
      chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNOPQRSTUVWXYZ123456789!@#$%^&*()_{}|:"<>?~,./;[]\\`'  
    end
    password = ''  
    length.times { |i| password << chars[rand(chars.length)] }  
    password  
  end

  def test_positve_amount_only
      #test that the receipt is valid
      r = Receipt.find_by_id(1)
      r.amount = 185.00
      assert r.valid?
      #test for a negative amount
      r.amount = -1
      assert !r.valid?, "The negative amount is valid"
      assert_equal "should be at least 0.01", r.errors.on(:amount)
      #test for a zero amount
      r.amount = 0
      assert !r.valid?, "The zero amount is valid"
      assert_equal "should be at least 0.01", r.errors.on(:amount)
  end
  
  def test_same_camper_id_same_unit
    r1 = Receipt.find_by_id(1)
    assert r1.valid?, "original receipt is not valid"
    # the original receipt is valid
    # now create one with the same camperid
    r = Receipt.new(
                    :unit_id=>1,
                    :lname=>"Test",
                    :fname=>"Test",
                    :payment_method=>1,
                    :camper1=>"Test Person",
                    :camper1_id=>"B001",
                    :phone=>"222-222-2222",
                    :amount=>185.00)
    assert !r.save
    assert_equal " id is already in use", r.errors.on(:camper1_id)
    #change the camper1 1 to be correct and then set the second one to be wrong
    r.camper1_id = "B002"
    r.camper2 = "Sally Weirdo"
    r.camper2_id = "G001"
    assert !r.save
    assert_equal nil, r.errors.on(:camper1_id), "the camper1_id is showing an error after being changed"
    assert_equal " id is already in use", r.errors.on(:camper2_id), "camper2 is not being checked for duplicates"
    #better check the third one
    r.camper2_id = "G002"
    r.camper3 = "Last Person"
    r.camper3_id = "B001"
    assert !r.save , "Receipt is able to be saved with camper3_id being the same"
    assert_equal " id is already in use", r.errors.on(:camper3_id), "camper3 is not being errored on duplicates"  
  end
  
  def test_camper_id_format_correct
    #first get the receipt we're going to use
    r = Receipt.find_by_id(1)
    assert r.valid? , "the original receipt is not valid"
    #BGSPAT
    r.camper1_id = "B001"
    assert r.valid?, "B001 is not a valid camper id"
    r.camper1_id = "G001"
    assert r.valid?, "G001 is not a valid camper id"
    r.camper1_id = "S001"
    assert r.valid?, "S001 is not a valid camper id"
    r.camper1_id = "P001"
    assert r.valid?, "P001 is not a valid camper id"
    r.camper1_id = "A001"
    assert r.valid?, "A001 is not a valid camper id"
    r.camper1_id = "T001"
    assert r.valid?, "T001 is not a valid camper id"
  end
  
  def test_camper_id_with_random_strings
    reg = Regexp.new("/^[BGSPAT]{1}\d{3}$/")
    r = Receipt.new(:unit_id=>1,
                    :lname=>"Test",
                    :fname=>"Test",
                    :payment_method=>1,
                    :camper1=>"Test Person",
                    :camper1_id=>"B005",
                    :phone=>"222-222-2222",
                    :amount=>185.00)
    assert r.valid?, "the original receipt is not valid"
    50.times do |t|
      (1..50).each do |num|
          test_id = generate_random_string(num)
          r.camper1_id = test_id
          unless reg.match(test_id)
            assert !r.valid?, "The id #{test_id} is showing as valid and shouldn't be"
          end    
      end
    end
  end
    
  def test_compact_phone
    r = Receipt.find_by_id(1)
    r.phone = "111-222-3333"
    assert_equal r.phone, "111-222-3333", "the phone is not what was entered"
    r.compact_phone
    assert_equal r.phone, "1112223333", "the phone was not compacted"
    r.phone = "1112223333"
    assert_equal r.phone, "1112223333", "the  phone compact causes problems on already compacted numbers"
  end
  
  def test_full_name
    r = Receipt.find_by_id(1)
    r.fname = "jason"
    r.lname = "draper"
    assert_equal r.full_name, "Jason Draper", "Full name did not function on lowercase"
    r.fname = "jAson"
    r.lname = "drAper"
    assert_equal r.full_name, "Jason Draper", "full name id dnot function with mixed case"
  end
  
  def test_payment_type
    r = Receipt.find_by_id(1)
    r.payment_method = 1
    assert_equal r.payment_type, "Cash", "Cash payment type is not working properly"
    r.payment_method = 2
    assert_equal r.payment_type, "Check", "Check payment type is not working properly"
    r.payment_method = 3
    assert_equal r.payment_type, "MO", "MO payment type is not working properly"
  end
  
  def test_payment_method_extra
    r = Receipt.find_by_id(1)
    assert r.valid? , "the original receipt is not valid"
    r.payment_method = 2
    assert !r.valid?, "payment extra is not being required on checks"
    assert_equal "You must add a check or money order number", r.errors.on(:payment_extra)
    r.payment_method = 3
    assert !r.valid?, "payment extra is not being required on money orders"
    assert_equal "You must add a check or money order number", r.errors.on(:payment_extra)
  end
  
  def test_phone_number_format
    check_number("222-222-2222",1,"Original receipt is not working")
    #first time a few that should work just find
    check_number("276-956-2436",1,"normal number is not working")
    check_number("2769562435",1, "normal number with no dashes is not working")
    #test a few that shouldn't work
    check_number("276-4445-2424",0,"too many numbers in the middle works")
    check_number("2325-222-555",0, "too many numbers at the front works")
    check_number("222-333-44444",0, "too many number at the end works")
    check_number("ada-232-1111",0,"letters work in the phone number")
    50.times do |t|
      (1..50).each do |num|
          number = generate_random_string(num)
          check_number(number, 0,"The id #{number} is showing as valid and shouldn't be") unless number =~ /^\d{3}-?\d{3}-?\d{4}$/ 
      end
    end
  end
  
  def check_number(number="222-222-2222", should_be_valid=1, msg="blank message")
    r = Receipt.new(:unit_id=>1,
                    :lname=>"Test",
                    :fname=>"Test",
                    :payment_method=>1,
                    :camper1=>"Test Person",
                    :camper1_id=>"B005",
                    :phone=>number,
                    :amount=>185.00)
    if should_be_valid==1
      assert r.valid?, msg
    else
      assert !r.valid?, msg
      assert_equal "is invalid", r.errors.on(:phone)
    end
  end

end
