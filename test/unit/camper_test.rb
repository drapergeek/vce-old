require 'test_helper'

class CamperTest < ActiveSupport::TestCase

  test "can save a valid camper from the default factory" do
    c = Factory.build(:camper)
    assert c.valid?
    assert c.save  
  end
  
  
  test "test the gender stuff" do
    Factory.create(:camper)
    Factory.create(:camper,:number=>"G234", :gender=>1)
    assert_equal 1, Camper.male.count
    assert_equal 1, Camper.female.count
    assert_difference "Camper.male.count" do 
      Factory.create(:camper, :number=>"B342")
    end
    assert_difference "Camper.female.count" do 
      Factory.create(:camper,:number=>"G244", :gender=>1)
    end
    assert_equal 2, Camper.male.count
    assert_equal 2, Camper.female.count
  end
  
  test "mark as fully paid for camper without a collage" do
    c = Factory.create(:camper)
    assert !c.paid_in_full?
    r = Factory.build(:receipt)
    r.camper1_id = c.number 
    r.camper1_payment = 220.00
    assert_equal r.camper1_id, c.number
    assert r.save
    c.reload
    assert c.paid_in_full?
  end
  
  test "inactive and active" do
    Factory.create(:camper, :inactive=>true, :inactive_info=>"Nope", :number=>"B231")
    assert_difference "Camper.inactive.count" do 
      Factory.create(:camper, :inactive=>true, :inactive_info=>"Blah")
    end
    assert_difference "Camper.active.count" do 
      Factory.create(:camper, :number=>"B421")
    end
  end
  
  test "camper scope" do
    assert_difference "Camper.campers.count" do
      Factory.create(:camper, :position=>0)
    end
  end
  
  test "teen scope" do
    assert_difference "Camper.teen.count" do
      Factory.create(:camper, :position=>1)
    end
  end
  
  test "cit scope" do
    assert_difference "Camper.cit.count" do
      Factory.create(:camper, :position=>2)
    end
  end
  
  test "adult scope" do
    assert_difference "Camper.adult.count" do
      Factory.create(:camper, :position=>3)
    end
  end
  
  test "must have inactive_info if a camper is" do
    c = Factory.build(:camper, :inactive=>true)
    assert !c.valid?
    c = Factory.build(:camper, :inactive=>true, :inactive_info=>"")
    assert !c.valid?
    c.inactive_info = "Blah"
    assert c.valid?
  end
  
  test "zip must be a number 5 digits long and not blank" do
    c = Factory.build(:camper)
    assert c.valid?, "Errors are #{c.errors}"
    c.zip = nil
    assert !c.valid?, "zip can't be blank"
    c.zip = "12313"
    assert c.valid?, "5 digit number is correct"
    c.zip = "123456"
    assert !c.valid?, "6 digit number fails"
    c.zip = "1234"
    assert !c.valid?, '4 digit number fails'
    c.zip = "blue1"
    assert !c.valid?, "ttext files"  
  end
  
  test "counselor years can be blank but must be a number if filled" do
    c = Factory.build(:camper, :counselor_years=>nil)
    assert c.valid? , "valid without counselor years"
    c.counselor_years = "this is all test"
    assert !c.valid?, "not valid with text"
    c.counselor_years = 2
    assert c.valid?, "valid with a number!"
  end
  
end
# == Schema Information
#
# Table name: campers
#
#  id                       :integer         not null, primary key
#  created_at               :datetime
#  updated_at               :datetime
#  fname                    :string(255)
#  lname                    :string(255)
#  mname                    :string(255)
#  pref_name                :string(255)
#  dob                      :date
#  gender                   :integer
#  address                  :string(255)
#  city                     :string(255)
#  state                    :string(255)
#  zip                      :integer
#  roomate_choice           :string(255)
#  parent_lname             :string(255)
#  parent_fname             :string(255)
#  phone1                   :string(255)
#  phone2                   :string(255)
#  emergency_name           :string(255)
#  emergency_phone          :string(255)
#  school                   :string(255)
#  teacher                  :string(255)
#  grade                    :integer
#  shirt_size               :integer
#  number                   :string(255)
#  position                 :integer
#  health_concerns          :text
#  bus_id                   :integer
#  inactive                 :boolean
#  inactive_info            :text
#  email                    :string(255)
#  race                     :string(255)
#  last_tetnus_shot         :date
#  code_of_conduct          :boolean
#  media_release            :integer
#  equine_release           :boolean
#  rec_zone                 :integer
#  payment_number           :string(255)
#  reference                :boolean
#  physician_insurance_info :boolean
#  emergency_info           :boolean
#  immunizations_current    :boolean
#  release_authorization    :boolean
#  parental_signatures      :boolean
#  pool_spotting            :integer
#  room_number              :string(255)
#  counselor_years          :integer
#  pack_id                  :integer
#  unit_id                  :integer
#

