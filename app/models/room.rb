class Room < ActiveRecord::Base
  has_many :campers
  belongs_to :pack

  delegate :name, to: :pack, prefix: true, allow_nil: true
end
