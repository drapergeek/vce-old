class CampersController < ApplicationController
  layout 'application', :except=>'export_excel_classes'
  helper_method :sort_column, :sort_direction

  def index
    authorize! :index, Camper
    if params[:search]
      logger.info @campers
      @campers = Camper.search(params[:search]).paginate(:per_page=>25, :page=>params[:page])
      if @campers.count > 5
        flash[:notice] = "Your search for \"#{params[:search]}\" did not return any results"
        params[:search] = nil
      end
    else
      @campers = Camper.order(sort_column + " "+ sort_direction).paginate(:per_page=>25, :page=>params[:page])
    end
  end

  def show
    authorize! :show, Camper
    if params[:number]
      #we're prob looking up someone
      @camper = Camper.find_by_number(params[:number])
      if @camper.blank?
        logger.info "Yea...its blank"
        flash[:notice] = 'This camper has not yet been created'
        redirect_to :action=>:new, :number=>params[:number], :name=>params[:name], :payment=>params[:payment] 
        return
      end
    end
    unless @camper
      @camper = Camper.find(params[:id])
    end
    @courses = Course.find(:all)
  end

  def find_by_number
    @camper = Camper.find_by_number(params[:number])
    if @camper
      redirect_to @camper 
    else
      flash[:error] = "Could not find a camper with that number"
      redirect_to campers_url
    end
  end

  def new
    authorize! :new, Camper
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
    @buses = Bus.all
    @packs = Pack.all
    @units = Unit.all
  end

  def create
    authorize! :create, Camper
    @camper = Camper.new(params[:camper])
    unless current_user.unit == 'State Wide'
      @camper.unit = current_user.unit
    end
    if @camper.save
      flash[:notice] = 'Camper was successfully created.'
      redirect_to :action => 'show', :id=>@camper
    else
      @states = State.all
      @schools = get_schools
      @buses = Bus.all
      @packs = Pack.all
      @units = Unit.all
      render :action => 'new'
    end
  end

  def edit
    authorize! :edit, Camper
    @camper = Camper.find(params[:id])
    @states = State.all
    @schools = get_schools
    @buses = Bus.all
    @packs = Pack.all
    @units = Unit.all
  end


  def update
    authorize! :update, Camper
    @camper = Camper.find(params[:id])
    if @camper.update_attributes(params[:camper])
      flash[:notice] = 'Camper was successfully updated.'
      redirect_to :action => 'show', :id => @camper
    else
      @states = State.find(:all)
      @schools = get_schools
      @buses = Bus.all
      @packs = Pack.all
      @units = Unit.all
      render :action => 'edit'
    end
  end

  def destroy
    authorize! :destroy, Camper
    Camper.find(params[:id]).destroy
    flash[:notice] = 'The camper was deleted successfully.'
    redirect_to campers_path
  end



  def existing_camper
    @camper = Camper.find_by_number(params[:number])
    logger.info @camper
    if @camper
      render :json=>@camper
    else
      render :status => 400, :json => {:status => :error, }.to_json
    end
  end


#untested
def list_by_input
  authorize! :list_by_input, Camper
  sort_init 'created_at'
  sort_update
  @campers = Camper.find(:all, :conditions=>["#{params[:find_by]} like ?", params[:item]])
  if @campers.blank? || @campers.empty?
    flash[:notice] = "No campers with #{params[:find_by]} like #{params[:item]}"
    redirect_to :action => 'index'
  else
    @campers = Camper.find(:all, :conditions=>["#{params[:find_by]} like ?", params[:item]]).paginate
    render :action=>'list'
  end
end

#This is mainly to pass to an rjs action
def update_camper_fields
  @type = params[:id]
end

#This method allows a course to be added to the list of courses for a camper
def add_course
  authorize! :add_course, Camper
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
  authorize! :remove_course, Camper
  @camper = Camper.find_by_id(params[:camper])
  @course = Course.find_by_id(params[:course])
  @camper.courses.delete(@course)
  flash[:notice] = "Removed course!"
  redirect_to @camper
end


private
#This is a method that just returns an array of schools 
#The method REALLY needs to replaced with a db call
def get_schools
  ['RAE','LPM', 'FCM', 'CES','AES','DME','Carlisle','PHE','MMS','SE','STE','MTO','JRS','CES','CCE','IE','MVH','BH','AHE','Other'].sort
end


def sort_column
  Camper.column_names.include?(params[:sort]) ? params[:sort] : "number"
end

def sort_direction
  %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
end




end
