class SessionsController < ApplicationController
  skip_before_filter :login_required
  
  def index
    
    
  end
  
  
  def new
    
    
  end
  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to root_url, :notice=>"Logged in!"
    else
      flash.now.alert =  "Invalid email or password"
      render "new"
    end
  end
  
  
  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out!"
    redirect_to :action=>:new
  end

end
