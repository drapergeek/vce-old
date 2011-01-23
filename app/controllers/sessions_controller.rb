class SessionsController < ApplicationController

  def index
    
    
  end
  def create
    if Rails.env=="testing"
      user = User.find_by_login(params[:login])
    else
      auth = request.env["omniauth.auth"]
      user = User.find_by_provider_and_uid(auth['provider'], auth['uid'])  || User.create_with_omniauth(auth)
    end

    if user
      if user.authorized
        flash[:notice] = "You have successfully logged in."
        session[:user_id] = user.id
      else
        flash[:notice] = "Your credentials have been saved, you are not yet authorized to use the system, please wait for an administrator to approve you."
      end
    else
      flash[:error] = "You are not authorized to use this system."
    end
    redirect_to :controller=>:sessions
  end
  
  
  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out!"
    redirect_to :controller=>:sessions
    
  end

end
