class Role < ActiveRecord::Base
  has_and_belongs_to_many :users 
  has_and_belongs_to_many :rights 
end

# == Schema Information
#
# Table name: roles
#
#  id   :integer         not null, primary key
#  name :string(255)
#

