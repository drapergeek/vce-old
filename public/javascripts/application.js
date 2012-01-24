// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function() {
  /*Receipts*/

   //hide or show the refund options
  $("#refund_link").click(function() {
    $("#refund_boxes").toggle();  
    return false;
  });


  //Watch for changing the payment methods
  $(".payment_method").change(function(){
    if ($(this).val()=="Cash") {
      $("#receipt_payment_extra_input").slideUp();
    }
    else{
      $("#receipt_payment_extra_input").slideDown();
    };
    return false;
  });


  /* End Receipts */
  
});
