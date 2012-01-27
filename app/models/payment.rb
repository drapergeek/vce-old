class Payment < ActiveRecord::Base
  belongs_to :camper
  belongs_to :receipt

  def to_s
    "Camper number:#{camper.number} Camper ID: #{camper.id} Receipt ID:#{receipt.id}"
  end
end
