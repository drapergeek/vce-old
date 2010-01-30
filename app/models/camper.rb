class Camper < ActiveRecord::Base
  belongs_to :receipt
  belongs_to :bus
  belongs_to :pack
  belongs_to :unit
  has_many :course_selections
  has_many :courses, :through=>:course_selections 
  before_create :compact_phone
  before_save :create_pack_from_name
  #named_scopes
  named_scope :current_unit, lambda {{:conditions=>["unit_id like ?", Thread.current["unit"].id]}}
  named_scope :current_year, lambda {{:conditions=>["created_at like ?", "%#{Date.today.year}%"]}}
  named_scope :active, :conditions=>["inactive not like ?", 1]
  named_scope :inactive, :conditions=>["inactive like ?", 1]
  named_scope :male, :conditions=>["gender like ?", 0]
  named_scope :female, :conditions=>["gender like ?", 1]
  named_scope :campers, :conditions=>["position like ?", 0]
  named_scope :teen, :conditions=>["position like ?", 1]
  named_scope :adult, :conditions=>["position like ?", 3]
  named_scope :cit, :conditions=>["position like ?", 2]
  named_scope :standard, lambda {{:conditions=>["unit_id like ? and created_at like ? and inactive not like ?", Thread.current["unit"].id, "%#{Date.today.year}%", 1]}}
  named_scope :unpaid, lambda {{:conditions=>["unit_id like ? and created_at like ? and inactive not like ? and payment_number like ?", Thread.current["unit"].id, "%#{Date.today.year}%", 1, '']}}
  
  validates_uniqueness_of :number
  validates_format_of :number, :with => /^(SB|SG|PG|PB|B|G|WB|WG|T|A|F)\d{3}$/
  validates_presence_of :fname, :mname, :lname, :pref_name, :gender
  validates_presence_of :position, :number
  validates_format_of :phone1, :with=>/^\d{3}-?\d{3}-?\d{4}$/, :if=>Proc.new { |u| !u.phone1.blank? } 
  validates_format_of :phone2, :with=>/^\d{3}-?\d{3}-?\d{4}$/, :if=>Proc.new { |u| !u.phone2.blank? } 
  validates_format_of :emergency_phone, :with=>/^\d{3}-?\d{3}-?\d{4}$/ , :if=>Proc.new { |u| !u.emergency_phone.blank? } 
  validates_numericality_of :zip
  validates_numericality_of :counselor_years,  :if=>Proc.new {|u| !u.counselor_years.blank?}
  validates_date :dob, :if=>Proc.new { |u| !u.dob.blank? } 
  validates_date :last_tetnus_shot, :if=>Proc.new { |u| !u.last_tetnus_shot.blank? } 
  
  attr_accessor :status
  attr_accessor :new_pack_name
  
  def self.find_all_by_year(year)
      find(:all, :conditions=>['created_at like ?', "%#{year}%"])
  end
  

  def create_pack_from_name
    create_pack(:name=>new_pack_name) unless new_pack_name.blank?
  end
  
  def compact_phone
    unless phone1.blank?
 	    @number = phone1.split('-')
 	    phone1 = @number.compact.join
 	    write_attribute(:phone1, phone1)
 	  end
 	  unless phone2.blank?
 	    @number2 = phone2.split('-')
 	    phone2 = @number2.compact.join
 	    write_attribute(:phone2, phone2)
 	  end
 	  unless emergency_phone.blank?
 	    @number3 = emergency_phone.split('-')
 	    emergency_phone = @number3.compact.join
 	    write_attribute(:emergency_phone, emergency_phone)
 	  end
  end
  
  
  def status
    if incomplete?
      return "Incomplete"
    elsif !bus_assigned?
      return "Bus Unassigneed"
    else
      return "Complete"
    end
  end
  
  def incomplete?
    unless physician_insurance_info? && immunizations_current? && code_of_conduct? && media_release_returned? && parental_signatures? && emergency_info? && release_authorization?
      return true
    end
  end
  
  
  def bus_assigned?
    unless bus.blank?
  		return true
  	end
  end
  
  
  def media_release_returned?
    if media_release==1 || media_release==2
      return true
    end
  end
  
  def parent_info_needed
    position==0 || position==1
  end
  
  def gender_text
    if gender==1
      return 'Female'
    else
      return 'Male'
    end
  end
  
  def proper_name
    [fname, mname, lname].each{ |name| name.capitalize!}.compact.join(" ")
  end

  
  def full_name
    [prefname, lname].each{ |word| word.capitalize! }.compact.join(" ")
  end
  
  def prefname
    if pref_name.blank?
      fname.capitalize
    else
      pref_name.capitalize
    end
  end
  
  
  def age
    if dob.blank?
      return 0
    else
      ((Date.today.strftime('%Y%m%d').to_i - dob.strftime('%Y%m%d').to_i ) / 10000 ).to_i
    end
  end
  
  def media_release_text
    case media_release
    when 1
      return 'Yes'
    when 2
      return 'This campers parent have denied media release ability.'
    else
      return 'No'
    end
  end
  
  def position_text
    case position
    when 0
      return 'Camper'
    when 1
      return 'Teen'
    when 2
      return 'CIT'
    else
      return 'Adult'
    end
  end
  
  def shirt_size_text
    case shirt_size
    when 0
      return "S"
    when 1
      return "M"
    when 2
      return "L"
    when 3
      return "XL"
    when 4
      return "XXL"
    when 5
      return "XXXL"
    else
      return "N/A"
    end
  end
  
  def pool_spotting_text
    case pool_spotting
    when 0
      return 'Rec 1 - Tuesday'
    when 1
      return 'Rec 1 - Wednesday'
    when 2
      return 'Rec 1 - Thursday'
    when 3
      return 'Rec 2 - Tuesday'
    when 4
      return 'Rec 2 - Wednesday'
    when 5
      return 'Rec 2 - Thursday'
    else
      return ' '
    end   
  end
  
  def self.search(search)
     if search
       #need to find a way to combine arrays
       @group = find(:all, :conditions=> ['lname like ?', "%#{search}%"])
       @group += find(:all, :conditions=> ['fname like ?', "%#{search}%"])
       @group += find(:all, :conditions=> ['mname like ?', "%#{search}%"])
       @group += find(:all, :conditions=> ['pref_name like ?', "%#{search}%"])
       @group += find(:all, :conditions=> ['phone1 like ?', "%#{search}%"])
       @group += find(:all, :conditions=> ['phone2 like ?', "%#{search}%"])
       @group += find(:all, :conditions=> ['number like ?', "%#{search}%"])
       if @group.empty?
         return nil
       elsif @group.uniq! == nil
        return @group
       else
        return @group
      end
     else
       return nil
     end
   end
  
  def validate
    if inactive==true
      errors.add(:inactive_info, "you must enter a reason for making the camper inactive") if inactive_info.blank?
    end
  end
  
end
