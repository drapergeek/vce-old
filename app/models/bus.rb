class Bus < ActiveRecord::Base
  has_many :campers
  belongs_to :unit
  
  def self.find_standard_buses(options={})
       with_scope :find => options do 
         find(:all, :conditions=>['unit_id like ?', Thread.current["unit"].id])
     end
   end
   
end
