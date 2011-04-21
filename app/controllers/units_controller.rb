class UnitsController < ApplicationController

  def index
    @units = Unit.find(:all)
  end

  def show
    @unit = Unit.find(params[:id])
  end

  def new
    @unit = Unit.new
  end

  def edit
    @unit = Unit.find(params[:id])
  end

  def create
    @unit = Unit.new(params[:unit])
    if @unit.save
      flash[:notice] = 'Unit was successfully created.'
      redirect_to(@unit) 
    else
      render :action => "new" 
    end
  end

  def update
    @unit = Unit.find(params[:id])
      if @unit.update_attributes(params[:unit])
        flash[:notice] = 'Unit was successfully updated.'
        redirect_to :action=>'show', :id=>@unit
      else
        render :action => "edit" 
      end
  end

  def destroy
    @unit = Unit.find(params[:id])
    @unit.destroy
    redirect_to(units_url) 
  end
end
