class ApplicationController < ActionController::Base
  before_filter :login_required 
  protect_from_forgery
  helper_method :current_user




  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to :login
  end
  
  private
  
  
  def current_user
    if defined?(@current_user)
       return @current_user
    else
      begin
         @current_user = User.find(session[:user_id]) if session[:user_id]
      rescue ActiveRecord::RecordNotFound => e
        reset_session
        flash[:warning] = "Your user record could not be located!"
        redirect_to root_url   
      end
       if @current_user
         set_thread_user
         set_thread_unit
         return @current_user
       end
    end
  end
  
  
  def login_required
    logger.info "The session user id is #{session[:user_id]}"
    unless current_user
      reset_session
      flash[:error] = "You must be logged in to view this page!"
      redirect_to :login
    end
  end
  
  
  def set_thread_user
      Thread.current["user"] = current_user  #current_user is part of Restful_Authentication
  end
  
  def set_thread_unit
      Thread.current["unit"] = current_user.unit  #current_user is part of Restful_Authentication
  end

  
  
end
