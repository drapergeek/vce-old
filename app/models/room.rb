class Room < ActiveRecord::Base
  has_many :campers
  belongs_to :pack
end
