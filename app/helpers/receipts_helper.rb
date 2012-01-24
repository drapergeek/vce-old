module ReceiptsHelper
  
  def payment_method_to_string(input)
     if input==1
       return 'Cash'
     else
       if input==2
         return 'Check'
       else
         return 'MO'
       end
     end
  end
  
  def sum_amount(receipts)
     number_to_currency(receipts.to_a.sum {|r| r.amount}) 
  end

  def camp_price_explanation(price)
			"**The price for two campers is #{number_to_currency(price  * 2)} and the price for 3 campers is #{number_to_currency(price *3)}**"
  end
  

  
  
  

  
end
