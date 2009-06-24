class User < ActiveRecord::Base
  acts_as_authentic do |c|
     c.transition_from_restful_authentication = true
   end
  has_many :receipts
  has_and_belongs_to_many :roles
  belongs_to :unit
  
end
