class ReceiptMailer < ActionMailer::Base
  def receipt_confirmation(receipt)
    recipients receipt.email
    from        "4hprogrammer@gmail.com"
    subject     "Thank you signing up for 4H Camp"
    body        :receipt=>receipt
    content_type "text/html"
  end
end
