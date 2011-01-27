module ApplicationHelper
  
  
  def can_view_item(controller, action)
#    if logged_in?
 ##       if current_user.roles.detect {|role| role.rights.detect {|right| right.action.downcase == action && right.controller.downcase == controller } } 
   #       return true
  #      else
  #        return false
  #      end
  #  end
  #  if current_user.roles.detect {|role| role.rights.detect {|right| right.action.downcase == action && right.controller.downcase == controller } } 
      return true
  #  else
  #    return false
  #  end
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
  

  def title(page_title)
    content_for(:title) { page_title }
  end
  
  def current_announcements
   @current_announcements ||= Annoucement.current_announcements(session[:announcement_hide_time])
  end
  
end
