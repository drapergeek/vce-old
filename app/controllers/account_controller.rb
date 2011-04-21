class AccountController < ApplicationController 
  def index
    logger.info 'got to index'
   # if current_user
      logger.info 'showing current user'
      @users = User.all
    #else
     # logger.info 'no current user'
    #  flash[:notice] = "You must be logged in to view this page"
    #  redirect_to login_path
    #end
    authorize! :index, User
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:notice] = "The user was successfully destroyed."
    redirect_to :action => 'index'
    authorize! :destroy, User
  end
  

  def image 
    @image = User.find(params[:id]) 
    send_data @image.picture, :filename => "photo.jpg", :type => @image.content_type, :disposition => "inline" 
  end 
   

  def signup
    @user = User.new(params[:user])
    @user.roles << Role.find_by_name("default")
    @units = Unit.find(:all)
    return unless request.post?
    unless @user.roles.detect{|role| role.name.downcase == "default"}
      @user.roles << Role.find_by_name("default")
    end
    if @user.save
      flash[:notice] = "User #{@user.fname} #{@user.lname} successfully created!"
      redirect_to :action=>:index
    else
      flash[:error] = "User could not be saved"
      render :signup
    end
    authorize! :signup, User
  end
  
  
  def edit
    @units = Unit.find(:all)
    if current_user.id.to_s == params[:id]
      @user = User.find(params[:id]) 
    else
      edit_another_user(params[:id])
    end
    authorize! :edit, User
  end
  
  def edit_another_user(id)
    @units = Unit.find(:all)
    @user = User.find_by_id(id)
    authorize! :edit_another_user, User
  end
  
  
  #this action updates the users information, everything works the save as the other basically
  def update
    @units = Unit.all
    @user = User.find(params[:id])
     if @user.update_attributes(params[:user])
       flash[:notice] = 'Your account was successfully updated'
       redirect_to :action=>'edit', :id=>@user
     else
       flash[:notice] = 'There was an error updating your user'
       render :action => 'edit'
     end
    authorize! :update, User
  end
  
  def logout
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been successfully logged out."
    redirect_to :controller => 'account', :action => 'login'
  end
end
