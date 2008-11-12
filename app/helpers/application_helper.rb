# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  
  def can_view_item(controller, action)
    if current_user.roles.detect {|role| role.rights.detect {|right| right.action.downcase == action && right.controller.downcase == controller } } 
      return true
    else
      return false
    end
  end
  
  def is_current_view(button)
    if controller.params[:controller] == button
       return true
    else
        return false
    end
  end
  
  def can_view_statistics(type)
    can_view_item("statistics", type)
  end
  
end
