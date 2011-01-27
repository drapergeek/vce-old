// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function change_payment_method(){
	if (document.getElementById("receipt_payment_method_cash").checked) {
		Element.hide("receipt_payment_extra_input");
	}
	else{
			Element.show("receipt_payment_extra_input");
	};
	
}

function add_camper_link(){
	
	
}