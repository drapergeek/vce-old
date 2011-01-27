class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user


  private
  
  
  
  def set_dev_user
    u = User.first
    session[:user_id] = u.id
    #just need to call this to set the current user
    current_user
  end
  
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
       end
    end
  end
  
  
  def login_required
    unless current_user
      logger.info "POOP"
      reset_session
      flash[:error] = "You must be logged in to view this page!"
      redirect_to :root
    end
  end
  
  
  def set_thread_user
      Thread.current["user"] = current_user  #current_user is part of Restful_Authentication
  end
  
  def set_thread_unit
      Thread.current["unit"] = current_user.unit  #current_user is part of Restful_Authentication
  end

  
  
end
