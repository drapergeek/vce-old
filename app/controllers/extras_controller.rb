class ExtrasController < ApplicationController
  before_filter :login_required , :except=>[:login, :index]  
  def index
    #this is for the reports and such
    #no info needed tho...
  end
  
  def list_campers_by_year
    @campers = Camper.find_all_by_year(params[:year])
    render :action =>'camper_search'
  end
  
  
  def demographics
    #this is a list enrolled camper demographics
    #grades
    #ethincity
    @campers = Camper.find_standard_campers
    @campers_grades = @campers.group_by{|c| c.grade}
#    @campers_races = @campers.group_by{|c| c.race}
    @campers_cities = @campers.group_by{|c| c.city}
    @campers_ages = @campers.group_by{|c| c.age}
    @campers_schools = @campers.group_by{|c| c.school}
    @campers_teachers = @campers.group_by{|c| c.teacher}
  end
end
