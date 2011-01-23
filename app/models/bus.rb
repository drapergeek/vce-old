class Bus < ActiveRecord::Base
  has_many :campers
  belongs_to :unit
  
  def self.find_standard_buses(options={})
       with_scope :find => options do 
         find(:all, :conditions=>['unit_id like ?', Thread.current["unit"].id])
     end
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

