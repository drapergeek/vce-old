class Bus < ActiveRecord::Base
  has_many :campers
  belongs_to :unit
  
  validates :capacity, :presence=>true
  def self.find_standard_buses()
    all
  end
  
  
  def current_load
    if self.campers.count > 0
      return self.campers.count
    else
      return 0
    end
  end
  
  def seats_remaining
    capacity - current_load
  end
end

# == Schema Information
#
# Table name: buses
#
#  id       :integer         not null, primary key
#  name     :string(255)
#  capacity :integer
#  info     :text
#  unit_id  :integer
#

