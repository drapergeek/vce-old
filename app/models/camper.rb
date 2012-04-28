class Camper < ActiveRecord::Base
  #associations
  belongs_to :receipt
  belongs_to :bus
  belongs_to :pack
  belongs_to :unit

  has_many :course_selections
  has_many :courses, :through=>:course_selections 
  has_many :payments
  has_many :receipts, :through=>:payments

  before_create :compact_phone
  before_save :create_pack_from_name

  attr_accessor :status
  attr_accessor :new_pack_name

  delegate :name, :to=>:bus, :prefix=>true, :allow_nil=>true

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
    where('lname LIKE :q OR fname LIKE :q OR mname LIKE :q OR pref_name like :q OR phone1 LIKE :q OR phone2 LIKE :q OR number like :q', :q =>"%#{search}%")
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
end

