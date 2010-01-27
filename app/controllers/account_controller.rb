class AccountController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  # If you want "remember me" functionality, add this before_filter to Application Controller
  #before_filter :login_from_cookie
  #before_filter :login_required , :except=>[:login, :index]
  #before_filter :authorize, :only=>[:signup, :super, :destroy, :index]
  skip_before_filter :check_authentication, :check_authorization , :only=>[:login, :index]


  
  def index
    logger.info 'got to index'
    if logged_in?
      logger.info 'showing current user'
      @users = User.find(:all)
    else
      logger.info 'no current user'
      flash[:notice] = "You must be logged in to view this page"
      redirect_to login_path
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    redirect_to :action => 'super'
  end
  

  def image 
    @image = User.find(params[:id]) 
    send_data @image.picture, :filename => "photo.jpg", :type => @image.content_type, :disposition => "inline" 
  end 
   
  
  def login
    return unless request.post?
    self.current_user = User.authenticate(params[:login], params[:password])
    if logged_in?
      if params[:remember_me] == "1"
        self.current_user.remember_me
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end
      redirect_back_or_default(:controller => 'receipts', :action => 'index')
      flash[:notice] = "Log in succesful"
    else
      flash[:notice] = "Username or password invalid"
    end
  end

  def signup
    @user = User.new(params[:user])
    @user.roles << Role.find_by_name("default")
    @units = Unit.find(:all)
    return unless request.post?
    unless @user.roles.detect{|role| role.name.downcase == "default"}
      @user.roles << Role.find_by_name("default")
    end
    @user.save!
    redirect_back_or_default(:controller => '/account', :action => 'index')
    flash[:notice] = "User #{@user.fname} #{@user.lname} successfully created!"
  rescue ActiveRecord::RecordInvalid
    render :action => 'signup'
  end
  
  
  def edit
    @units = Unit.find(:all)
    if current_user.id.to_s == params[:id]
      @user = User.find(params[:id]) 
    else
      edit_another_user(params[:id])
    end
  end
  
  def edit_another_user(id)
    @units = Unit.find(:all)
    @user = User.find_by_id(id)
  end
  
  
  #this action updates the users information, everything works the save as the other basically
  def update
    @user = User.find(params[:id])
     if @user.update_attributes(params[:user])
       flash[:notice] = 'Your account was successfully updated'
       redirect_to :controller=>'receipts', :action => 'index'
     else
       flash[:notice] = 'There was an error updating your user'
       render :action => 'edit'
     end
    
  end
  
  def logout
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been successfully logged out."
    redirect_to :controller => 'account', :action => 'login'
  end
end
