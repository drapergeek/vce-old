class UsersController < ApplicationController
  load_and_authorize_resource
  
   def index
    @users = User.all     
   end

   def new
   end

   def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to users_path, :notice=>"Successfully created user"
    else
      render :new
    end
   end

   def edit
   end

   def update
    if @user.update_attributes(params[:user])  
      redirect_to users_path, :notice=>"Succesfully updated user"
    else
      render :edit
    end
   end

   def destroy
     if @user.destroy
       redirect_to users_path, :notice=>"Successfully destroyed user"  
     else
       redirect_to users_path, :notice=>"Could not delete user"
     end
   end



end
