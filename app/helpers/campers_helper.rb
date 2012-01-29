module CampersHelper
  def inactive_information(camper)
    if camper.inactive
      content_tag :div, :id=>"camper_inactive_show" do
        content_tag :h3, "**Please note this camper will not be attending camp due to the following reason:**"
        content_tag :p,camper.inactive_info
      end
    end
  end

  def if_assigned(input)
    if input.blank?
      "Not Assigned" 
    else
      input
    end
  end
  
end
