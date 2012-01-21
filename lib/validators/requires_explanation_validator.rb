  class RequiresExplanationValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
       if value
         if record.refund_amount.nil? || record.refund_amount <  0.01
           record.errors[:refund_amount] << "you must enter a refund amount"
         end
         if record.refund_check_number.blank?
           record.errors[:refund_check_number] << "you must enter a refund check number"
         end
         if record.refund_info.blank?
           record.errors[:refund_info] << "you must explain why the amount was refunded"
         end
       end
     end
  end
  
