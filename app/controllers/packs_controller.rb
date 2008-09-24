class PacksController < ApplicationController
  before_filter :login_required 
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @packs = Pack.paginate_standard_packs :page=>params[:page], :per_page=>10
  end

  def show
    @pack = Pack.find(params[:id])
  end

  def new
    @pack = Pack.new
  end

  def create
    @pack = Pack.new(params[:pack])
     unless current_user.unit == 'State Wide'
        @pack.unit = current_user.unit
      end
    if @pack.save
      flash[:notice] = 'Pack was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @pack = Pack.find(params[:id])
  end

  def update
    @pack = Pack.find(params[:id])
    if @pack.update_attributes(params[:pack])
      flash[:notice] = 'Pack was successfully updated.'
      redirect_to :action => 'show', :id => @pack
    else
      render :action => 'edit'
    end
  end

  def destroy
    Pack.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
