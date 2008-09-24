# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  include ExceptionNotifiable 
 # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_vce_session_id'
  before_filter :set_thread_user, :set_thread_unit
  
    def set_thread_user
      if logged_in?
        Thread.current["user"] = current_user  #current_user is part of Restful_Authentication
      end
    end
    def set_thread_unit
      if logged_in?
        Thread.current["unit"] = current_user.unit  #current_user is part of Restful_Authentication
      end
    end
  
  ExceptionNotifier.exception_recipients = %w(aethiolas@gmail.com)  
  
  protected
  
  
  
  
  def authorize
    if logged_in?
      unless current_user.admin?
        flash[:error] = "Unauthorized access"
        redirect_to :controller=>'account', :action=>'login'
        false
      end
    end
  end
  
  #this needs to be something a bit better...like a field...?
  #def admin?
   # if logged_in?
    #  current_user.login=="gdraper" || current_user.login=="ddraper" || current_user.login=="bhairston"
    #else
     # return false
    #end
  #end
  


end
