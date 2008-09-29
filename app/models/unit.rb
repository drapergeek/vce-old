class Unit < ActiveRecord::Base
  has_many :users
  has_many :campers
  has_many :receipts
  has_many :buses
  has_many :packs
  has_many :courses
  validates_numericality_of :camp_price
  
end
