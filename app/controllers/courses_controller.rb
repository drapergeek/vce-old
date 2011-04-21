class CoursesController < ApplicationController
  load_and_authorize_resource
  Course.content_columns.each do |column| 
	  in_place_edit_for :course, column.name 
  end  
 
  def index
    @courses = Course.all  
  end


  def show
    @course = Course.find(params[:id])
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(params[:course])
     unless current_user.unit == 'State Wide'
        @course.unit = current_user.unit
      end
    if @course.save
      flash[:notice] = 'Course was successfully created.'
      redirect_to :action => 'index'
    else
      render :action => 'new'
    end
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])
    if @course.update_attributes(params[:course])
      flash[:notice] = 'Course was successfully updated.'
      redirect_to :action => 'show', :id => @course
    else
      render :action => 'edit'
    end
  end

  def destroy
    Course.find(params[:id]).destroy
    redirect_to :action => 'index'
  end
end
