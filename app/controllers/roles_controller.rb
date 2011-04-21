class RolesController < ApplicationController 
  load_and_authorize_resource
  def index
    @roles = Role.find(:all)
  end

  def show
    @role = Role.find(params[:id])
  end

  def new
    @role = Role.new 
  end

  def edit
    @role = Role.find(params[:id])
  end

  def create
    @role = Role.new(params[:role])
      if @role.save
        flash[:notice] = 'Roles was successfully created.'
        redirect_to @role 
      else
        render :action => "new"
      end
  end

  def update
    @role = Role.find(params[:id])
    if @role.update_attributes(params[:role])
        flash[:notice] = 'Roles was successfully updated.'
        redirect_to :action=>'show', :id=>@role
    else
        render :action => "edit"
    end
  
  end


  def destroy
    @role = Role.find(params[:id])
    @role.destroy
    redirect_to(roles_url)
  end
end
