class PacksController < ApplicationController
  def index
    @packs = Pack.all
    authorize! :index, Pack
  end

  def show
    @pack = Pack.find(params[:id])
    authorize! :show, @pack
  end

  def new
    @pack = Pack.new
    authorize! :new, @pack
  end

  def create
    authorize! :create, Pack
    @pack = Pack.new(params[:pack])
     unless current_user.unit == 'State Wide'
        @pack.unit = current_user.unit
      end
    if @pack.save
      flash[:notice] = 'Pack was successfully created.'
      redirect_to packs_path
    else
      render :action => 'new'
    end
  end

  def edit
    @pack = Pack.find(params[:id])
    authorize! :edit, @pack
  end

  def update
    @pack = Pack.find(params[:id])
    authorize! :update, @pack
    if @pack.update_attributes(params[:pack])
      flash[:notice] = 'Pack was successfully updated.'      
      redirect_to :action => 'show', :id => @pack
    else
      render :action => 'edit'
    end
  end

  def destroy
    authorize! :destory, Pack
    Pack.find(params[:id]).destroy
    redirect_to packs_path, :notice=>"Destroyed pack"
  end
end
