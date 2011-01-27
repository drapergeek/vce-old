require 'test_helper'

class CamperTest < ActiveSupport::TestCase
  test "can save a valid camper from the default factory" do
    assert Factory.build(:camper).valid?
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

