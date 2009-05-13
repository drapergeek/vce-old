class ExcelController < ApplicationController
  include ActionView::Helpers::NumberHelper
  layout 'application', :only=>'custom_excel'
  require 'fastercsv'
  before_filter :login_required 

  def receipts_all
    @receipts = Receipt.find_standard_receipts
    stream_csv do |csv|
      @header = ["Receipt Number","Date Taken"]
      @header.push("Payer First Name")
      @header.push("Payer Last Name")
      @header.push("Address")
      @header.push("City")
      @header.push("State")
      @header.push("Zip")
      @header.push("Phone")
      @header.push("Amount Paid")
      @header.push("Payment Method")
      @header.push("Check/MO Number")
      @header.push("Camper 1")
      @header.push("Camper 1 ID")
      @header.push("Camper 2")
      @header.push("Camper 2 ID")
      @header.push("Camper 3")
      @header.push("Camper 3 ID")
      @header.push("Refunded Amount")
      @header.push("Refund Date")
      @header.push("Refund Check #")
      csv << @header
      @receipts.each do |u|
        @outs = [u.id, u.date]
        @outs.push(u.fname)
        @outs.push(u.lname) 
        @outs.push(u.address) 
        @outs.push(u.city)
        @outs.push(u.state)
        @outs.push(u.zip)
        @outs.push(number_to_phone(u.phone))
        @outs.push(u.amount)
        @outs.push(u.payment_type)
        @outs.push(u.payment_extra)
        @outs.push(u.camper1)
        @outs.push(u.camper1_id.titleize)
        @outs.push(u.camper2)
        @outs.push(u.camper2_id.titleize)
        @outs.push(u.camper3)
        @outs.push(u.camper3_id.titleize)
        if u.refund==true
          @outs.push(u.refund_amount)
          @outs.push(u.refund_date)
          @outs.push(u.refund_check_number)
        else
          @outs.push(" ")
          @outs.push(" ")
          @outs.push(" ")
        end
        csv << @outs
      end
    end
  end
  
  
  
  #this will give a basic listing of all campers
  def camper_list
    
    
  end

  def bus_list
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
  
  
  
  def all_camper_info
    @campers = Camper.find_standard_campers
      stream_csv do |csv|
        @header = ["First Name","Middle Name", "Last Name", "Preferred Name"]
        @header.push("Camper ID")
        @header.push("Position")
        @header.push("Address")
        @header.push("City")
        @header.push("State")
        @header.push("Zip")
        @header.push("DOB")
        @header.push("Sex")
        @header.push("Roomate Choice")
        @header.push("Parent First")
        @header.push("Parent Last")
        @header.push("Phone")
        @header.push("Alt Phone")
        @header.push("Emergency Contact")
        @header.push("Emergency Phone")
        @header.push("School")
        @header.push("Grade")
        @header.push("Shirt Size")
        @header.push("Bus Assignment")
        @header.push("E-mail")
        @header.push("Race")
        @header.push("Tetnus Shot")
        @header.push("Code of Conduct")
        @header.push("Media Release")
        @header.push("Equine Release")
        @header.push("Rec Zone")
        @header.push("Payment Number")
        @header.push("Reference")
        @header.push("Doctor/Insurance Info")
        @header.push("Emergency Info")
        @header.push("Immunizations")
        @header.push("Release Authorization")
        @header.push("Parental Signatures")
        @header.push("Pool Spotting")
        @header.push("Room Number")
        @header.push("Inactive Info")
        
        
        #classes
        @header.push('Class 1')
        @header.push('Class 2')
        @header.push('Class 3')
        @header.push('Class 4')
        @header.push('Class 5')
        @header.push('Class 6')
        @header.push('Class 7')
        @header.push('Class 8')
        
        
        csv << @header
        @campers.each do |u|
          logger.info 'I got into the @campers.each do'
          @outs = [u.fname,u.mname, u.lname, u.pref_name]
          @outs.push(u.number)
          @outs.push(u.position_text)
          @outs.push(u.address)
          @outs.push(u.city)
          @outs.push(u.state)
          @outs.push(u.zip)
          @outs.push(u.dob)
          @outs.push(u.gender_text)
          @outs.push(u.roomate_choice)
          @outs.push(u.parent_fname)
          @outs.push(u.parent_lname)
          @outs.push(u.phone1)
          @outs.push(u.phone2)
          @outs.push(u.emergency_name)
          @outs.push(u.emergency_phone)
          @outs.push(u.school)
          @outs.push(u.grade)
          @outs.push(u.shirt_size_text)          
          unless u.bus.blank? then @outs.push(u.bus.name) else @outs.push("") end
          @outs.push(u.email)
          @outs.push(u.race)
          @outs.push(u.last_tetnus_shot)
          if u.code_of_conduct? then @outs.push("Yes") else @outs.push("No") end
          if u.media_release? then @outs.push("Yes") else @outs.push("No") end
          if u.equine_release? then @outs.push("Yes") else @outs.push("No") end
          @outs.push(u.rec_zone)
          @outs.push(u.payment_number)
          if u.reference? then @outs.push("Yes") else @outs.push("No") end
          if u.physician_insurance_info? then @outs.push("Yes") else @outs.push("No") end
          if u.emergency_info? then @outs.push("Yes") else @outs.push("No") end
          if u.immunizations_current? then @outs.push("Yes") else @outs.push("No") end
          if u.release_authorization? then @outs.push("Yes") else @outs.push("No") end
          if u.parental_signatures? then @outs.push("Yes") else @outs.push("No") end
          @outs.push(u.pool_spotting_text)
          @outs.push(u.room_number)
          if u.inactive? then @outs.push(u.inactive_info) else @outs.push("") end
          unless u.courses.empty?
            u.courses.each do |c|
              @outs.push(c.name)
            end
          end
          csv << @outs
        end
      end
  
  end


  def bus_list
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
     @campers = Camper.find_standard_campers
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
    @campers = Camper.find_standard_campers
    stream_csv do |csv|
      @header = ['Camper Name', 'Issue']
      csv<<@header
      @campers.each do |c|
        unless c.health_concerns.blank?
          @writer =[c.full_name, c.health_concerns]
          csv<<@writer
        end
        
      end
    end  
  end
  
  def demographic_report
    #this is a list enrolled camper demographics
    @campers = Camper.find_standard_campers 
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
        filename = params[:action] + ".csv"    
        #this is required if you want this to work with IE        
        if request.env['HTTP_USER_AGENT'] =~ /msie/i
          headers['Pragma'] = 'public'
          headers["Content-type"] = "text/plain" 
          headers['Cache-Control'] = 'no-cache, must-revalidate, post-check=0, pre-check=0'
          headers['Content-Disposition'] = "attachment; filename=\"#{filename}\"" 
          headers['Expires'] = "0" 
        else
          headers["Content-Type"] ||= 'text/csv'
          headers["Content-Disposition"] = "attachment; filename=\"#{filename}\"" 
        end
       render :text => Proc.new { |response, output|
         csv = FasterCSV.new(output, :row_sep => "\r\n") 
         yield csv
       }
     end
end
