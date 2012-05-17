class ExcelController < ApplicationController
  include ActionView::Helpers::NumberHelper
  layout 'application', :only=>'custom_excel'

  def unpaid_campers
    authorize :unpaid_campers, Camper
    @campers = Camper.unpaid
    stream_csv do |csv|
      @header = ["First Name","Middle Name", "Last Name", "Preferred Name"]
      @header.push("Camper ID")
      csv << @header
      @campers.each do |u|
        logger.info 'I got into the @campers.each do'
        @outs = [u.fname,u.mname, u.lname, u.pref_name]
        @outs.push(u.number)
        csv << @outs
      end
    end
  end

  def bus_list
    authorize :bus_list, Bus
    @buses = Bus.find(:all)
    stream_csv do |csv|
      @buses.each do |b|
        csv << b.name
        b.campers.each do |c|
          csv<< c.full_name
        end
        csv << " "
        csv << " "
      end
    end
  end

  def bus_list
    authorize! :bus_list, Bus
    @buses = Bus.find(:all)
    stream_csv do |csv|
      @buses.each do |b|
        csv << b.name
        b.campers.each do |c|
          csv<< c.full_name
        end
        csv << " "
        csv << " "
      end
    end
  end

  def campers_classes
    authorize! :campers_class, Camper
    @campers = Camper.standard
    stream_csv do |csv|
      @header = ["First Name","Last Name", "Preferred Name"]
      @header.push("Pack")
      @header.push("Room")
      @header.push("Bus")
      @header.push('Class 1')
      @header.push('Class 2')
      @header.push('Class 3')
      @header.push('Class 4')

      csv << @header
      @campers.each do |u|
        @outs = [u.fname, u.lname, u.pref_name]
        if u.pack.blank?
          @outs.push("Empty")
        else
          @outs.push(u.pack.name)
        end
        if u.room_number.blank?
          @outs.push("Empty")
        else
          @outs.push(u.room_number)
        end
        if u.bus.blank?
          @outs.push("Empty")
        else
          @outs.push(u.bus.name)
        end
        unless u.courses.empty?
          u.courses.each do |c|
            @outs.push(c.name)
          end
        end
        csv << @outs
      end
    end
  end


  def health_concerns
    authorize! :health_concerns, Camper
    @campers = Camper.standard
    stream_csv do |csv|
      @header = ['Camper Name', 'Issue', 'Room Number']
      @header.push('Class 1')
      @header.push('Class 2')
      @header.push('Class 3')
      @header.push('Class 4')
      csv<<@header
      @campers.each do |c|
        unless c.health_concerns.blank?
          @writer =[c.full_name, c.health_concerns, c.room_number]
          unless c.courses.empty?
            c.courses.each do |c|
              @writer.push(c.name)
            end
          end
          csv<<@writer
        end
      end
    end
  end

  def demographic_report
    authorize! :demographic_report, Camper
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


    stream_csv do |csv|
      csv<<'Grade Levels'
      unless @campers_grades.empty?
        @campers_grades.keys.sort.each do |grade, campers|  
          @writer = Array.new
          @writer.push(grade.ordinalize)
          @writer.push(@campers_grades[grade].length)
          csv<<@writer
        end 
      end
      csv<<''
      csv<<'Ethnicities'

    end



  end

  #the following methods are for creating custom excel sheets
  #they are not currently being used
  def custom_excel

  end

  def create_excel
    @checked = Array.new
    if params[:columns]
      params[:columns].each do |key, value|
        @checked << key
      end
    end
    stream_csv do |csv|
      #insert the headers
      csv << @checked
      Receipt.find(:all).each do |t|
        @outputs = Array.new
        @checked.each do |c|
          @outputs.push(eval("t.#{c}"))
        end#end of @checked.each
        csv << @outputs
      end#end of Receipts.each 
    end
  end

  private
  def stream_csv
    logger.info "streamming"
    filename = params[:action] + ".csv"    
    #this is required if you want this to work with IE        
    if request.env['HTTP_USER_AGENT'] =~ /msie/i
      headers['Pragma'] = 'public'
      headers["Content-type"] = "text/plain" 
      headers['Cache-Control'] = 'no-cache, must-revalidate, post-check=0, pre-check=0'
      headers['Content-Disposition'] = "attachment; filename=\"#{filename}\"" 
      headers['Expires'] = "0" 
    else
      logger.info "got into the else"
      headers["Content-Type"] ||= 'text/csv'
      headers["Content-Disposition"] = "attachment; filename=\"#{filename}\"" 
    end

    content = FasterCSV.generate( :row_sep => "\r\n" ) do |csv|
      yield csv
    end

    send_data content, :filename => filename
    #render :text => Proc.new { |response, output|
    # logger.info "got into the render text thingy..."
    ## logger.info "Response is"
    # logger.info response
    ## logger.info "output is "
    # logger.info output
    # csv = FasterCSV.new(output, :row_sep => "\r\n") 
    # yield csv
    #}
  end
end
