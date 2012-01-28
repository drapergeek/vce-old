// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function() {
  /*Receipts*/

  //hide or show the refund options
  $("#refund_link").click(function() {
    $("#refund_boxes").slideToggle();  
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
      camp_price = numFromString("#camp_price");
      $(payment).val(camp_price);
    };
    updateFinalPrice();
  return false;
  });

  //watch the collages for updates 
  $(".camper_collage_input").change(function(){
      //Set up all our names
      id = $(this).attr("id");
      camper_number = id.substring(14,15);
      payment = "#receipt_camper" + camper_number + "_payment";
      collage_price = numFromString("#collage_price");
    if ($(this).is(":checked")) {
      //need to up the payment
       if ($(payment).val()) {
          amount = numFromString(payment)+collage_price;
          $(payment).val(amount);
       }
       else{
         //Do not allow a collage to be added until we have a camper
         alert("You must fill in the camper information before selecting a collage");
         $(this).removeAttr("checked");
       };
    }
    else{
      //need to lower the payment amount
      if ($(payment).val()) {
        amount = numFromString(payment)-collage_price;
        $(payment).val(amount);
      };
      
    };
    updateFinalPrice();
  return false;
  });
  /* End Receipts */
 
  //Looks up the camper ID
  //will alert if there is already a camper with this ID
  $(".camper_id_input").change(function(){
     val = $(this).val();
     check_for_existing_camper(val, this);
   });

});

function check_for_existing_camper(number, field){
    $.ajax({
      url:"/campers/existing_camper?number="+number,
      dataType:"json",
      complete:function(req){
        if (req.status == 200 | req.status == 304) {
          camper = $.parseJSON(req.responseText);
          camper = camper.camper
          response = confirm("HEY!  There is already a camper with this number registered.  The camper's name is " + camper.fname + " " + camper.lname + ".  If you're ok with this, click ok, if you think you made a mistake, please click cancel!");
          if (response!==true) {
            $(field).val("");
          }
        }
      }
    }); 
   return false;
}


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

