class BusesController < ApplicationController
  before_filter :login_required 
  def index
    list
    render :action => 'list'
  end

  
  def error
   raise RuntimeError, "Generating an error"
  end 

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @buses = Bus.paginate_standard_buses :per_page=>10, :page=>params[:page]
  end

  def show
    @bus = Bus.find(params[:id])
  end
  
  def add_campers
    @bus = Bus.find(params[:id])
    @campers = Camper.find_standard_campers
  end
  
  def add_camper_to_bus
   id = params[:bus]
   @checked = Array.new
    if params[:campers]
        params[:campers].each do |key, value|
          @checked << key
        end
    end
    if @checked.length==0
      flash[:notice] = "You must select campers to be added before updating!"
    else
      @checked.each do |c|
        logger.info("this what is listed" + c)
        @camper = Camper.find(c)
        @camper.bus_id = id
        @camper.save
      end
      flash[:notice] = "The campers were successfully added to the bus"
    end
    redirect_to :action=>'add_campers', :id=>id
  end

  def new
    @bus = Bus.new
  end

  def create
    @bus = Bus.new(params[:bus])
     unless current_user.unit == 'State Wide'
        @bus.unit = current_user.unit
      end
    if @bus.save
      flash[:notice] = 'Bus was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end
  
  def remove_camper
    #this method removes a camper from the bus
    @camper = Camper.find(params[:id])
    current_bus = @camper.bus_id
    @camper.bus_id = ""
    if @camper.save
      flash[:notice] = 'The camper was successfully removed'
    else
      flash[:notice] = 'There was a problem removing the camper from the bus'
    end
    redirect_to :action=>'show', :id=>current_bus
  end

  def edit
    @bus = Bus.find(params[:id])
  end

  def update
    @bus = Bus.find(params[:id])
    if @bus.update_attributes(params[:bus])
      flash[:notice] = 'Bus was successfully updated.'
      redirect_to :action => 'show', :id => @bus
    else
      render :action => 'edit'
    end
  end

  def destroy
    Bus.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
