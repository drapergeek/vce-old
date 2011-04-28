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
  
  
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end
  

  def primary_link(name, path, action, model, controller_name)
    logger.info "The action is #{action} and the model is #{model}"
    if can? action, model
      if is_current_view controller_name 
        content_tag(:li, :id=>"current") do 
          link_to name, path
        end
      else
        content_tag(:li) do
           link_to name, path
        end
      end
    end
  end
end
