class Receipt < ActiveRecord::Base
  belongs_to :user
  belongs_to :unit
  has_many :campers
  before_create :compact_phone
  #attr_accessor :phone
  validates_presence_of :lname, :fname, :payment_method, :camper1, :camper1_id, :amount
  validates_format_of :camper1_id, :with => /^(SB|SG|PG|PB|B|G|WB|WG|T|A|F)\d{3}$/, :on => :create
  validates_format_of :camper2_id, :with => /^(SB|SG|PG|PB|B|G|WB|WG|T|A|F)\d{3}$/, :on => :create, :if=> :camper2_filled
  validates_format_of :camper3_id, :with => /^(SB|SG|PG|PB|B|G|WB|WG|T|A|F)\d{3}$/, :on => :create, :if=> :camper3_filled
  validates_format_of :phone, :with=>/^\d{3}-?\d{3}-?\d{4}$/, :on=>:create
  named_scope :current_unit, lambda {|unit|{:conditions=>["unit_id like ?", unit]}}
  named_scope :current_year, lambda {|year|{:conditions=>["created_at like ?", year]}}
  
  CAMP_PRICE = 200.00
   
  HUMANIZED_ATTRIBUTES = {
      :date => "Date Created",
      :fname => "Payer First Name",
      :lname => "Payer Last Name",
      :address => "Address"
    }
    
 
  
    

  def self.human_attribute_name(attr)
      HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end
  

  
  def self.find_standard_receipts(options={})
      with_scope :find => options do 
        year = Date.today.year
        find(:all, :conditions=>['unit_id like ? and created_at like ?', Thread.current["unit"].id, "%#{year}%"])
      end
  end
  
  
 
 def compact_phone
	@number = phone.split('-')
	phone = @number.compact.join
	write_attribute(:phone, phone)
 end

 #This is a simple search
 #returns results based on lname, fname,camper1-3 name or id and phone
  def self.search(search)
    if search
      #need to find a way to combine arrays
      @group = find(:all, :conditions=> ['lname like ?', "%#{search}%"])
      @group += find(:all, :conditions=> ['fname like ?', "%#{search}%"])
      @group += find(:all, :conditions=> ['camper1 like ?', "%#{search}%"])
      @group += find(:all, :conditions=> ['camper1_id like ?', "%#{search}%"])
      @group += find(:all, :conditions=> ['camper2 like ?', "%#{search}%"])
      @group += find(:all, :conditions=> ['camper2_id like ?', "%#{search}%"])
      @group += find(:all, :conditions=> ['camper3 like ?', "%#{search}%"])
      @group += find(:all, :conditions=> ['camper3_id like ?', "%#{search}%"])
      @group += find(:all, :conditions=> ['phone like ?', "%#{search}%"])
      return @group
  end
end
  
  #This finds all the camper ids only...I don't know where this is used
  def self.find_camper_ids()
    @ids = Array.new
    @receipts = Receipt.find(:all)
    @receipts.each do |r|
      @ids.push(r.camper1_id)
      @ids.push(r.camper2_id) unless r.camper2_id.blank?
      @ids.push(r.camper3_id) unless r.camper3_id.blank?
    end
    @ids
  end
  
  def camper2_filled
     !camper2.blank?
  end
  
  def camper3_filled
    !camper3.blank?
  end
  

  def payment_type
    case payment_method
      when 1 : return "Cash"
      when 2 : return "Check"
      when 3 : return "MO"
    end
  end
  
  def full_name
    [fname.capitalize, lname.capitalize].join(' ')
  end
  
  def full_address
    full_address = address + " " + city + ", " + state + " " + zip.to_s
  end
  
  #this method checks to see if ANY part of the address was left out
  def address_blank?
    address.blank? || state.blank? || zip.blank? || city.blank?
  end
 
  protected 
  
  
  def validate
    errors.add(:amount, "should be at least 0.01") if amount.nil? || amount < 0.01 

    #payment method extra
    unless payment_method==1
      if payment_extra.blank?
        errors.add(:payment_extra, "You must add a check or money order number")
      end
    end
    
    #check for refund stuff
    if refund==true
      errors.add(:refund_amount, "You must enter a refund amount") if refund_amount.nil? || amount < 0.01
      errors.add(:refund_check_number, "You must enter a refund check number") if refund_check_number.blank?
      errors.add(:refund_info, "You must add why the amount was refunded") if refund_info.blank?
      
    end
    
    unless self.zip.to_s.size == 5 || self.zip.blank?
        errors.add("zip", "should be 5 digits")
      end
  
  end#end of validate class 
  
  def validate_on_create
    #check for camper_ids being unique
    @camper_ids = find_camper_ids()
    camper1_id_used = 0
    camper2_id_used = 0
    camper3_id_used = 0
    @camper_ids.each do |i|
      if i == camper1_id
        camper1_id_used = 1
      end
      if :camper2_filled
        if i == camper2_id
          camper2_id_used =  1
        end 
      end
      if :camper3_filled
         if i == camper3_id
            camper3_id_used =  1
          end
      end
      
    end# end of the camper_ids loop
    
    if camper1_id_used == 1
      errors.add(:camper1_id, " id is already in use")
    end
    
    if camper2_id_used == 1
      errors.add(:camper2_id, " id is already in use")
    end
    
    if camper3_id_used == 1
      errors.add(:camper3_id, " id is already in use")
    end
    #end of validating the camper_ids
    
  end

end
