class Unit < ActiveRecord::Base
  has_many :users
  has_many :campers
  has_many :receipts
  has_many :buses
  has_many :packs
  has_many :courses
  has_many :issues
  has_many :possible_issues
  validates_numericality_of :camp_price
  
end

# == Schema Information
#
# Table name: units
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  camp_price :float
#

