class Receipt < ActiveRecord::Base
  belongs_to :user
  belongs_to :unit
  has_many :campers
  before_create :compact_phone


  #validations
  include ActiveModel::Validations
  
  #custom validations
  class PostivePriceValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      if value.nil? || value < 0.01 
        record.errors[attribute] << "should be at least 0.01"
      end
    end
  end

  class RequiresExplanationValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
       if value
         if record.refund_amount.nil? || record.refund_amount <  0.01
           record.errors[:refund_amount] << "you must enter a refund amount"
         end
         if record.refund_check_number.blank?
           record.errors[:refund_check_number] << "you must enter a refund check number"
         end
         if record.refund_info.blank?
           record.errors[:refund_info] << "you must explain why the amount was refunded"
         end
       end
     end
  end
  
  
  class CamperIdMustBeUniqueValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      Receipt.all.each do |r|
        if r.camper1_id == value || r.camper2_id == value || r.camper3_id == value
          unless value.blank?  || value == ""
            record.errors[attribute] << "must be unique" 
          end
        end
      end
    end
  end

  #end custom validations
  

  validates_presence_of :lname, :fname, :payment_method, :camper1, :camper1_id, :amount
  validates_format_of :camper1_id, :with => /^(SB|SG|PG|PB|B|G|WB|WG|T|A|F)\d{3}$/, :on => :create
  validates_format_of :camper2_id, :with => /^(SB|SG|PG|PB|B|G|WB|WG|T|A|F)\d{3}$/, :on => :create, :if=> :camper2_filled
  validates_format_of :camper3_id, :with => /^(SB|SG|PG|PB|B|G|WB|WG|T|A|F)\d{3}$/, :on => :create, :if=> :camper3_filled
  validates_format_of :phone, :with=>/^\d{3}-?\d{3}-?\d{4}$/, :on=>:create
  validates_format_of  :email, :with       => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :allow_blank=>true, :message => 'email must be valid'
  validates :amount, :postive_price=>true
  validates :refund, :requires_explanation=>true
  validates :zip, :presence=>true, :length=>{:minimum=>5}
  validates :camper1_id, :camper_id_must_be_unique=>true, :on=>:create
  validates :camper2_id, :camper_id_must_be_unique=>true, :on=>:create
  validates :camper3_id, :camper_id_must_be_unique=>true, :on=>:create
#  scope :current_unit, lambda {|unit|{:conditions=>["unit_id like ?", unit]}}
#  scope :current_year, lambda {|year|{:conditions=>["created_at like ?", year]}}
  

   
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
    #can we get the current unit _id?
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
  
  def find_camper_ids()
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
 
end

# == Schema Information
#
# Table name: receipts
#
#  id                  :integer         not null, primary key
#  date                :datetime
#  fname               :string(255)
#  lname               :string(255)
#  address             :string(255)
#  state               :string(255)
#  zip                 :integer
#  city                :string(255)
#  amount              :float
#  payment_method      :integer
#  payment_extra       :string(255)
#  camper1             :string(255)
#  camper1_id          :string(255)
#  camper2             :string(255)
#  camper2_id          :string(255)
#  camper3             :string(255)
#  camper3_id          :string(255)
#  account_id          :integer
#  user_id             :integer
#  phone               :string(255)
#  refund              :boolean
#  refund_date         :datetime
#  refund_check_number :integer
#  refund_amount       :float
#  refund_info         :text
#  created_at          :datetime
#  unit_id             :integer
#  email               :string(255)
#

