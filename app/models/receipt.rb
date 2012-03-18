class Receipt < ActiveRecord::Base
  PAYMENT_TYPES = ["Check", "Cash", "Money Order"]
  belongs_to :user
  belongs_to :unit
  has_many :payments
  has_many :campers
  before_create :compact_phone
  after_create :create_payments
  after_create :add_collages
  after_create :send_email

  #validations
  #include ActiveModel::Validations

  validates_presence_of :lname, :fname, :payment_method, :camper1, :camper1_id, :amount
  validates_format_of :phone, :with=>/^\d{3}-?\d{3}-?\d{4}$/, :on=>:create
  validates_format_of  :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :allow_blank=>true, :message => 'email must be valid'
  validates :amount, :positive_price=>true
  validates :refund, :requires_explanation=>true
  validates :zip, :presence=>true

  def self.find_standard_receipts(options={})
    with_scope :find => options do 
      year = Date.today.year
      find(:all, :conditions=>['created_at like ?',  "%#{year}%"])
    end
  end

  def compact_phone
    @number = phone.split('-')
    phone = @number.compact.join
    write_attribute(:phone, phone)
  end

  def self.search(search)
    if search
      @group = where('lname like ?', "%#{search}%")
      @group += where('fname like ?', "%#{search}%")
      @group += where('camper1 like ?', "%#{search}%")
      @group += where('camper1_id like ?', "%#{search}%")
      @group += where('camper2 like ?', "%#{search}%")
      @group += where('camper2_id like ?', "%#{search}%")
      @group += where('camper3 like ?', "%#{search}%")
      @group += where('camper3_id like ?', "%#{search}%")
      if @group.empty?
        return scoped
      else
        if @group.count > 1
          return @group.uniq
        else
          return @group
        end
      end
    else
      scoped
    end
  end

  def create_payments
   #create a payment for all three campers if there are three 
    if camper1_id && camper1 && camper1_payment
      c = Camper.find_or_create_by_number(:number=>camper1_id, :name=>camper1,:position=>0)
      c.save(:validate=>false)
      c.payments.create(:receipt=>self, :amount=>camper1_payment)
    end 
    if camper2_id && camper2 && camper2_payment
      c = Camper.find_or_create_by_number(:number=>camper2_id, :name=>camper2, :position=>0)
      c.save(:validate=>false)
      c.payments.create(:receipt=>self, :amount=>camper2_payment)
    end 
    if camper3_id && camper3 && camper3_payment
      c = Camper.find_or_create_by_number(:number=>camper3_id, :name=>camper3, :position=>0)
      c.save(:validate=>false)
      c.payments.create(:receipt=>self, :amount=>camper3_payment)
    end
  end

  def add_collages
     if camper1_id && camper1_collage
       c = Camper.find_by_number(camper1_id).add_collage
     end
     if camper2_id && camper2_collage
       c = Camper.find_by_number(camper2_id).add_collage
     end
     if camper3_id && camper3_collage
       c = Camper.find_by_number(camper3_id).add_collage
     end
  end

  def camper2_filled
    !camper2.blank?
  end

  def camper3_filled
    !camper3.blank?
  end

  def full_name
    [fname.capitalize, lname.capitalize].join(' ')
  end

  def full_address
    full_address = address + " " + city + ", " + state + " " + zip.to_s
  end

  def address_blank?
    address.blank? || state.blank? || zip.blank? || city.blank?
  end

  def send_email
    ReceiptMailer.receipt_confirmation(self).deliver unless self.email.blank?
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

