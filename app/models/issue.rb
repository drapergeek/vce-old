class Issue < ActiveRecord::Base
  attr_accessible :name, :description, :ignore
  belongs_to :unit
  named_scope :active, :conditions=>{:ignore=>false}
  named_scope :standard, lambda {{:conditions=>["unit_id like ?", Thread.current["unit"].id]}}
  
end
