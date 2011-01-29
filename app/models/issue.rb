class Issue < ActiveRecord::Base
  attr_accessible :name, :description, :ignore
  belongs_to :unit
  scope :active, where(:ignore=>false)
  scope :standard, lambda {where("unit_id like ?", Thread.current["unit"].id_)}
  
end
