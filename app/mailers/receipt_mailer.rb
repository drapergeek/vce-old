class ReceiptMailer < ActionMailer::Base
  default :from => "4hcamp@drapergeek.com"
  
  def receipt_confirmation(receipt)
    @receipt = receipt
    mail(:to=>receipt.email, :subject=>"4-H Camp 2012 Receipt")
  end
end
