class PositivePriceValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.nil? || value < 0.01 
      record.errors[attribute] << "should be at least 0.01"
    end
  end
end
