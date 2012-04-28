class Receipt < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  PAYMENT_TYPES = ["Check", "Cash", "Money Order"]
  belongs_to :user
  belongs_to :unit
  has_many :payments, :dependent => :destroy
  has_many :campers
  before_create :compact_phone
  after_create :create_payments
  after_create :send_email

  #validations
  #include ActiveModel::Validations

  validates_presence_of :lname, :fname, :payment_method, :camper1, :camper1_id, :amount
  validates_format_of :phone, :with => /^\d{3}-?\d{3}-?\d{4}$/, :on=>:create
  validates_format_of  :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :allow_blank=>true, :message => 'email must be valid'
  validates :amount, :positive_price => true
  validates :refund, :requires_explanation => true
  validates :zip, :presence => true

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

  def self.get_duplicates
    dups = {}
    Receipt.all.each do |receipt|
      Receipt.all.each do |r|
        if r.id != receipt.id && r.fname == receipt.fname && r.lname == receipt.lname
          dups[receipt.id] = receipt
        end
      end
    end
  end

  def self.search(search)
    where('lname like :q OR fname like :q oR camper1 like :q OR camper1_id like :q OR camper2 like :q OR camper2_id like :q OR camper3 like :q OR camper3_id like :q', :q => "%#{search}%")
  end

  def create_payments
    if camper1_id && camper1 && camper1_payment
      Camper.create_from_receipt(self, camper1_id, camper1, camper1_collage, camper1_payment)
    end
    if camper2_id && camper2 && camper2_payment
      Camper.create_from_receipt(self, camper2_id, camper2, camper2_collage, camper2_payment)
    end
    if camper3_id && camper3 && camper3_payment
      Camper.create_from_receipt(self, camper3_id, camper3, camper3_collage, camper3_payment)
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

  def formatted_phone
    number_to_phone(phone, :area_code =>true)
  end

  comma do
    created_at 'Receipt Date'
    fname
    lname
    address
    city
    state
    zip
    formatted_phone
    amount
    payment_method
    payment_extra
    email
    camper1
    camper1_id
    camper1_payment
    camper1_collage
    camper2
    camper2_id
    camper2_payment
    camper2_collage
    camper3
    camper3_id
    camper3_payment
    camper3_collage
    refund_amount
    refund_date
    refund_check_number
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

