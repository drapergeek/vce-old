class Payment < ActiveRecord::Base
  belongs_to :camper
  belongs_to :receipt
end
