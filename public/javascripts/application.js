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



  //Watch the camper spots for change so we can update everything
  $(".camper_name_input").change(function(){
      //Set up all our names
      id = $(this).attr("id");
      camper_number = id.substring(id.length-1);
      collage = "#receipt_camper" + camper_number + "_collage";
      camper_id = "#receipt_camper" + camper_number + "_id";
      payment = "#receipt_camper" + camper_number + "_payment";
    if (!$(this).val()) {
      //we need to clear the value in the amount box and remove the collage checkbox
      $(collage).removeAttr("checked");
      $(camper_id).val("");
      $(payment).val("");
    }
    else{
      //We need to calculate the camp price and add it to the box at the end
      camp_price = $("#camp_price").val();
      $(payment).val(camp_price);
    };
    updateFinalPrice();
  return false;
  });

  
  /* End Receipts */

});

function updateFinalPrice() {
  camper1 = numFromString("#receipt_camper1_payment");
  camper2 = numFromString("#receipt_camper2_payment");
  camper3 = numFromString("#receipt_camper3_payment");
  total_amount = camper1 + camper2 + camper3 
  $("#receipt_amount").val(total_amount);
}

function numFromString(string){
  if ($(string).val()) {
     return parseFloat($(string).val()); 
  }
  else{
     return 0;
  };
}

