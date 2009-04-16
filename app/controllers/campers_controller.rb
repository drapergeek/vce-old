class CampersController < ApplicationController
  layout 'application', :except=>'export_excel_classes'
  helper :sort
  before_filter :login_required 
  before_filter :authorize, :only=>:destroy
  include SortHelper
  
  

  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
      sort_init 'created_at'
      sort_update
      @campers = Camper.paginate_standard_campers :page=>params[:page], :per_page=>20, :order=>sort_clause
  end
  
  
  def search
    @campers = Camper.search(params[:search])
    if @campers.blank? || @campers.empty?
      flash[:notice] = "There were no campers matching the search term \"#{params[:search]}\""
      redirect_to :action=>'index'
    end
    @header_text = "Search Results for \"#{params[:search]}\""
    @link_text = 'Back to all active Campers'
    @link_action = 'list'
  end
  
  #This is mainly to pass to an rjs action
  def update_camper_fields
    @type = params[:id]
  end
  
  #This method allows a course to be added to the list of courses for a camper
  def add_course
    @camper = Camper.find(params[:id])
    if params[:course_selection].blank?
      flash[:notice] = "You must select a course to be added to the camper"
      redirect_to :action=>'show', :id=>@camper
    else
      @course = Course.find(params[:course_selection])
      @camper.courses << @course
      redirect_to :action=>'show', :id=>@camper
    end
  end
  
  #this method allows the removal of a course from a campers list of courses
  #It assumes that it exists due to the fact that the x would not exist
  #For the user to click
  def remove_course
    @camper = Camper.find_by_id(params[:camper])
    @course = Course.find_by_id(params[:course])
    @camper.courses.delete(@course)
    return if request.xhr?
    render :nothing, :status => 200
  end
  
  def show
    @camper = Camper.find(params[:id])
    @courses = Course.find(:all)
  end
  
  
  def find
    @camper = Camper.find_by_number(params[:number])
    if @camper.blank?
      flash[:notice] = 'This camper has not yet been created'
      redirect_to :action=>'new', :number=>params[:number], :name=>params[:name], :payment=>params[:payment]
    else
      redirect_to :action=>'show', :id=>@camper
    end
  end
  
  def new
      unless params[:name].blank? || params[:number].blank?
        @names = params[:name].split(' ')
        if @names.length==2
          @camper = Camper.new(:number=>params[:number], :fname=>@names[0], :lname=>@names[1], :payment_number=>params[:payment])
        elsif @names.length==3
          @camper = Camper.new(:number=>params[:number], :fname=>@names[0], :mname=>@names[1], :lname=>@names[2], :payment_number=>params[:payment])
        else
          @camper = Camper.new(:number=>params[:number], :fname=>@names[0], :payment_number=>params[:payment])
        end
      else
        @camper = Camper.new
      end
      @states = State.find(:all)
      @schools = get_schools
      @buses = Bus.find_standard_buses
      @packs = Pack.find_standard_packs
      @units = Unit.find(:all)
  end


  def create
    @camper = Camper.new(params[:camper])
    unless current_user.unit == 'State Wide'
      @camper.unit = current_user.unit
    end
    if @camper.save
      flash[:notice] = 'Camper was successfully created.'
      redirect_to :action => 'show', :id=>@camper
    else
      @states = State.find(:all)
      @schools = get_schools
      @buses = Bus.find_standard_buses
      @packs = Pack.find_standard_packs
      @units = Unit.find(:all)
      render :action => 'new'
    end
  end

  def edit
    @camper = Camper.find(params[:id])
    @states = State.find(:all)
    @schools = get_schools
    @buses = Bus.find_standard_buses
    @packs = Pack.find_standard_packs
    @units = Unit.find(:all)
  end

  def update
    @camper = Camper.find(params[:id])
    if @camper.update_attributes(params[:camper])
      flash[:notice] = 'Camper was successfully updated.'
      redirect_to :action => 'show', :id => @camper
    else
      @states = State.find(:all)
      @schools = get_schools
      @buses = Bus.find_standard_buses
      @packs = Pack.find_standard_packs
      @units = Unit.find(:all)
      render :action => 'edit'
      
    end
  end

  def destroy
    Camper.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  
  def list_inactive
    @campers = Camper.find_all_inactive
    @header_text = "Inactive Campers"
    @link_text = "Back to Reports"
    @link_action = 'report'
    render :action=>'search'
  end
  
  def list_camper_type
    @campers = Camper.find_by_type(params[:type])
    @header_text = "#{params[:type]} Attendees"
    @link_text = 'Back to Reports'
    @link_action = 'report'
    render :action=>'search'
  end

  
  
  private
  #This is a method that just returns an array of schools
  #The method REALLY needs to replaced with a db call
  def get_schools
    ['RAE','LPM', 'FCM', 'CES','AES','DME','FCM','Carlisle','PHE','MMS','SE','STE','MTO','JRS','CES','CCE','IE','MVH','BH','Other'].sort
   end
  



end
