require 'test_helper'

class ReceiptTest < ActiveSupport::TestCase
  
  test "can create a receipt from factory" do
    r = Factory.build(:receipt)
    assert r.valid?
  end

  test "receipt amount can't be negative or nil" do
    r = Factory.build(:receipt, :amount=>nil)
    assert !r.valid?
    assert r.errors[:amount]
    r.amount = "0.01"
    assert r.valid?
    r.amount = "0.00"
    assert !r.valid?
  end
  
  test "refunds require extra fields" do
    r = Factory.build(:receipt)
    assert r.valid?
    r.refund = true
    assert !r.valid?
    r.refund_amount =  2.00
    assert !r.valid?
    r.refund_check_number = "1231"
    assert !r.valid?
    r.refund_info = "I felt like it, deal with it"
    assert r.valid?
  end
  
  test "cant reuse camper ids" do
    r = Factory.build(:receipt)
    assert r.valid?
    r.save!
    r2 = Factory.build(:receipt)
    assert !r2.valid?
    r2.camper1_id = "G123"
    assert r2.valid?
    r2.camper2_id = r.camper1_id
    assert !r2.valid? , "Camper is still valid after changing camper2_id"
    r2.camper2_id = "G444"
    assert r2.valid?
    r2.camper3_id = r.camper1_id
    assert !r2.valid?
  end

  test "receipt will create payments for new campers" do
    r = Factory.build(:all_camper_receipt) 
    assert r.save
    c = Camper.find_by_number(r.camper1_id)
    assert_not_nil c
    assert_equal r.camper1_payment, c.payments.first.amount
    c = Camper.find_by_number(r.camper2_id)
    assert_not_nil c
    assert_equal r.camper2_payment, c.payments.first.amount
    c = Camper.find_by_number(r.camper3_id)
    assert_not_nil c
    assert_equal r.camper3_payment, c.payments.first.amount
  end

  test "receipt will add collages properly" do
    r = Factory.build(:all_camper_receipt) 
    assert r.save
    [r.camper1_id, r.camper2_id, r.camper3_id].each do |c|
      c = Camper.find_by_number(c)
      assert c.collage_purchased
    end
  end
  
end

# == Schema Information
#
# Table name: receipts
#
#  id                  :integer         not null, primary key
#  date                :datetime
#  fname               :string(255)
#  lname               :string(255)
#  address             :string(255)
#  state               :string(255)
#  zip                 :integer
#  city                :string(255)
#  amount              :float
#  payment_method      :integer
#  payment_extra       :string(255)
#  camper1             :string(255)
#  camper1_id          :string(255)
#  camper2             :string(255)
#  camper2_id          :string(255)
#  camper3             :string(255)
#  camper3_id          :string(255)
#  account_id          :integer
#  user_id             :integer
#  phone               :string(255)
#  refund              :boolean
#  refund_date         :datetime
#  refund_check_number :integer
#  refund_amount       :float
#  refund_info         :text
#  created_at          :datetime
#  unit_id             :integer
#  email               :string(255)
#

