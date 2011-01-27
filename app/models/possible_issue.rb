class PossibleIssue < ActiveRecord::Base
  attr_accessible :name, :description, :ignore
  belongs_to :unit
end
