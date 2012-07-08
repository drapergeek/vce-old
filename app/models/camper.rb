class Camper < ActiveRecord::Base
  #associations
  belongs_to :receipt
  belongs_to :bus
  belongs_to :unit
  belongs_to :room

  has_many :course_selections
  has_many :courses, :through=>:course_selections
  has_many :payments
  has_many :receipts, :through=>:payments

  before_create :compact_phone

  attr_accessor :status

  delegate :name, :to=>:bus, :prefix=>true, :allow_nil=>true
  delegate :name, :to=>:room, :prefix=>true, :allow_nil=>true

  #named_scopes
  scope :current_unit, lambda {|*args| where("unit_id like ?", Thread.current["unit"].id)}
  scope :current_year, lambda {{:conditions=>["created_at like ?", "%#{Date.today.year}%"]}}
  scope :active, where("inactive is null OR inactive = ?", 0)#tested
  scope :inactive, where(:inactive=>true)#tested
  scope :male, where(:gender => 0)#tested
  scope :female, where(:gender=>1)#tested
  scope :campers, where(:position=>0)#tested
  scope :teen, where(:position=>1)#tested
  scope :adult, where(:position=>3)#tested
  scope :cit, where(:position=>2)#tested
  scope :standard, lambda {{:conditions=>["unit_id like ? and created_at like ? and inactive not like ?", Thread.current["unit"].id, "%#{Date.today.year}%", 1]}}
  scope :unpaid, lambda {{:conditions=>["unit_id like ? and created_at like ? and inactive not like ? and payment_number like ?", Thread.current["unit"].id, "%#{Date.today.year}%", 1, '']}}

  #validations
  #custom validators
  class MustExplainValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      if value=="" || value.blank? || value.empty? 
        if record.inactive==true
          record.errors[attribute] << " must explain why the camper is inactive'" 
        end
      end
    end
  end


  #normal validations
  validates :number, :uniqueness=>true, :format=>{:with => /^(CWG|CWB|CG|CB|SG|SB|PG|PB|TG|TB|AG|AB)\d{3}$/}, :presence=>true
  validates :fname, :presence=>true
  validates :lname, :presence=>true
  validates :mname, :presence=>true
  validates :pref_name, :presence=>true
  validates :gender, :presence=>true
  validates :position, :presence=>true
  validates :phone1, :format=>{:with=>/^\d{3}-?\d{3}-?\d{4}$/}, :allow_blank=>true
  validates :phone2, :format=>{:with=>/^\d{3}-?\d{3}-?\d{4}$/}, :allow_blank=>true
  validates :emergency_phone, :format=>{:with=>/^\d{3}-?\d{3}-?\d{4}$/}, :allow_blank=>true

  validates :zip, :inclusion=>{:in=>10000...99999}, :numericality=>true, :presence=>true
  validates :counselor_years, :numericality=>true, :allow_nil=>true
  validates_date :dob, :allow_nil=>true
  validates_date :last_tetnus_shot, :allow_nil=>true
  validates :inactive_info, :must_explain=>true

  def self.find_by_full_name(first_name, last_name)
    unit = Thread.current["unit"].id
    current_year = Date.today.year
  end

  def self.find_all_by_year(year)
    find(:all, :conditions=>['created_at like ?', "%#{year}%"])
  end

  def self.create_from_receipt(receipt, number, name, collage_count, payment_amount)
    c = Camper.find_or_create_by_number(:number=>number, :name=>name,:position=>"Camper")
    c.save(:validate=>false)
    c.add_collage(collage_count)
    c.payments.create(:receipt=>receipt, :amount=>payment_amount)
  end


  def course_list
    courses.map { |course| course.name }.join(",")
  end

  (1..4).each do |number|
    define_method("course_#{number}") do
      if course_selections[number-1]
        course_selections[number-1].course.name
      end
    end
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
    if mname
      [fname, mname, lname].each{ |name| name.capitalize!}.compact.join(" ")
    else
      [fname, lname].each{ |name| name.capitalize!}.compact.join(" ")
    end
  end

  def add_collage(count)
    self.update_attribute(:collage_count, self.collage_count + count)
  end

  def paid_in_full?
    return true if fully_paid
    amount = 210
    if collage_purchased
      amount += 10
    end
    self.payments.sum(:amount) >= amount
  end


  def full_name
    [prefname, lname].each{ |word| word.capitalize! }.compact.join(" ")
  end

  def header
    full_name + " " + number 
  end

  def prefname
    if pref_name.blank?
      fname.capitalize
    else
      pref_name.capitalize
    end
  end


  def age
    return "No Birthday Set" if dob.blank?
    ((Date.today.strftime('%Y%m%d').to_i - dob.strftime('%Y%m%d').to_i ) / 10000 ).to_i
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

  def name=(input)
    names = input.split(" ")
    if names.length == 3
      self.mname = names[2]
    else
      self.mname = "Unknown"
    end
    self.fname = names[0]
    self.lname = names[1]
  end

  def pack_name
    if room && room.pack
      return room.pack_name
    else
      nil
    end
  end

  def self.search(search)
    where('lname LIKE :q OR fname LIKE :q OR mname LIKE :q OR pref_name like :q OR phone1 LIKE :q OR phone2 LIKE :q OR number like :q', :q =>"%#{search}%")
  end

  comma do
    fname
    lname
    mname
    pref_name
    dob
    gender
    address
    city
    state
    zip
    roomate_choice
    parent_lname
    parent_fname
    phone1
    phone2
    emergency_name
    emergency_phone
    school
    teacher
    grade
    shirt_size
    number
    position
    health_concerns
    bus_name
    email
    race
    last_tetnus_shot
    code_of_conduct
    media_release
    equine_release
    rec_zone
    payment_number
    reference
    physician_insurance_info
    immunizations_current
    release_authorization
    parental_signatures
    pool_spotting
    counselor_years
    pack_name
    mother_name
    mother_phone
    mother_email
    father_name
    father_phone
    father_email
    guardian_name
    guardian_phone
    guardian_email
    collage_count
    inactive
    inactive_info
    course_1
    course_2
    course_3
    course_4
    room_name
  end




  US_STATES = ['AL','AK','AZ','AR','CA','CO', 'CT', 'DE', 'DC', 'FL', 'GA', 'HI', 'ID',
    'IL', 'IN', 'IA', 'KS', 'KY', 'LA', 'ME', 'MD', 'MA', 'MI', 'MN', 'MS', 'MO',
    'MT', 'NE', 'NV', 'NH', 'NJ', 'NM', 'NY', 'NC', 'ND', 'OH', 'OK', 'OR',
    'PA', 'PR', 'RI', 'SC', 'SD', 'TN', 'TX', 'UT', 'VT', 'VA', 'WA', 'WV',
    'WI', 'WY']
  GRADES = [3,4,5,6,7,8,9,10,11,12]
  SHIRT_SIZES = %w(S M L XL XXL)
  RACES = ["Black", "White", "American Indian", "Hispanic", "Asian", "Multi-Cultural", "Other"]
  MEDIA_RELEASE = ["No", "Yes", "Parents Denied Permission"]
  POSITIONS = ["Camper", "CIT", "Teen", "ADULT"]
  REC_ZONES  = [
    "Tues. 1st Fish",
    "Tues. 2nd Fish",
    "Tues. 1st Putt Putt",
    "Tues. 2nd Putt Putt",
    "Tues. 1st Board Games",
    "Tues. 2nd Board Games",
    "Tues. 1st Open Air",
    "Tues. 2nd Open Air",
    "Tues. 1st Skate Park",
    "Tues. 2nd Skate Park",
    "Wed. 1st Fish",
    "Wed. 2nd Fish",
    "Wed. 1st Putt Putt",
    "Wed. 2nd Putt Putt",
    "Wed. 1st Board Games",
    "Wed. 2nd Board Games",
    "Wed. 1st Open Air",
    "Wed. 2nd Open Air",
    "Wed. 1st Skate Park",
    "Wed. 2nd Skate Park",
    "Thurs. 1st Fish",
    "Thurs. 2nd Fish",
    "Thurs. 1st Putt Putt",
    "Thurs. 2nd Putt Putt",
    "Thurs. 1st Board Games",
    "Thurs. 2nd Board Games",
    "Thurs. 1st Open Air",
    "Thurs. 2nd Open Air",
    "Thurs. 1st Skate Park",
    "Thurs. 2nd Skate Park"
  ]
  POOL_SPOTTING = [
    "Tuesday 1st Rec",
    "Tuesday 2nd Rec",
    "Wed. 1st Rec",
    "Wed. 2nd Rec",
    "Thurs. 1st Rec",
    "Thurs. 2nd Rec"
  ]
end

