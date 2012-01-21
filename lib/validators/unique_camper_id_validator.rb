class UniqueCamperIdValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    Receipt.all.each do |r|
      if r.camper1_id == value || r.camper2_id == value || r.camper3_id == value
        unless value.blank?  || value == ""
          record.errors[attribute] << "must be unique" 
        end
      end
    end
  end
end
