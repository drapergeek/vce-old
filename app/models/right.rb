class Right < ActiveRecord::Base
  has_and_belongs_to_many :roles 
  
end

# == Schema Information
#
# Table name: rights
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  controller :string(255)
#  action     :string(255)
#

