class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  include ExceptionNotifiable 
 # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_vce_session_id'
  before_filter :set_thread_user, :set_thread_unit
  before_filter :check_authentication, :check_authorization
  
  
  def check_authentication 
    unless session[:user] 
      session[:intended_action] = action_name 
      redirect_to :controller => "account", :action => "index" 
      return false 
    end 
  end 
  
  def check_authorization 
  user = User.find(session[:user]) 
  logger.debug user.login
  #need to check for the new type of "rights"
  if (action_name.downcase=~/\d/) == nil
    action = action_name.downcase
  else
    #need to find out what it is...
    action= 'update'
  end
    unless user.roles.detect{|role| role.rights.detect{|right| right.action.downcase == action.downcase && right.controller.downcase == controller_name.downcase } } 
      user.roles.each do |r|
        r.rights.each do |rr|
          logger.debug rr.controller.to_s
          logger.debug rr.action.to_s
        end
      end
      flash[:notice] = "You are not authorized to view the page you requested " + controller_name + " - " + action
      request.env["HTTP_REFERER"] ? (redirect_to :back) : (redirect_to home_url) 
      return false 
    end 
  end
  
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