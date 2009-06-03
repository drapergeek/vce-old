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
    @campers = Camper.standard 
    @campers_grades = Array.new
    @campers_races = Array.new
    @campers_cities = Array.new
    @campers_ages = Array.new
    @campers_schools  = Array.new
    @campers_teachers = Array.new
    @campers.each do |c|
      unless c.grade.blank?
        @campers_grades<<c
      end
      unless c.race.blank?
        @campers_races<<c
      end
      unless c.city.blank?
        @campers_cities<<c
      end
      unless c.age.blank?
        @campers_ages<<c
      end
      unless c.school.blank?
        @campers_schools<<c
      end
      unless c.teacher.blank?
        @campers_teachers<<c
      end
    end  
    @campers_grades = @campers_grades.group_by{|c| c.grade unless c.grade.blank?}
    @campers_races = @campers_races.group_by{|c| c.race}
    @campers_cities = @campers_cities.group_by{|c| c.city }
    @campers_ages = @campers_ages.group_by{|c| c.age}
    @campers_schools = @campers_schools.group_by{|c| c.school}
    @campers_teachers = @campers_teachers.group_by{|c| c.teacher}
  end
end
