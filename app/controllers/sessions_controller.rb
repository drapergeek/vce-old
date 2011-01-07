class SessionsController < ApplicationController
  def index
    
    
  end
  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth['provider'], auth['uid'])
    if user
      flash[:notice] = "You have successfully logged in."
      session[:user_id] = user.id
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
