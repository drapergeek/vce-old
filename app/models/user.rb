require 'digest/sha1'
class User < ActiveRecord::Base
  
  before_save :encrypt_password
  attr_accessor :password
  attr_accessible :email, :password, :password_confirmation
  attr_protected :authorized
  has_many :authentications
  has_many :receipts
  has_and_belongs_to_many :roles
  belongs_to :unit

  validates_length_of       :email,    :within => 3..100
  validates_uniqueness_of   :email, :case_sensitive => false
  validates_confirmation_of :password
  validates_presence_of :password, :on=>:create
  
  scope :authorized, where(:authorized=>true)
  scope :unauthorized, where(:authorized=>false)



  def pictureimg=(picture_field) 
    return if picture_field.blank? 
    self.content_type = picture_field.content_type.chomp 
    self.picture = picture_field.read 
  end 
  
  def role?(role)
    roles.all.each do |r|
      if r.name.to_sym == role
        return true
      end
    end
    false
  end

  def authorize!
    self.authorized=true
    self.save!
  end
  
  def self.authenticate(email, password)
    user = find_by_email(email)
    if user
      logger.info "we at least found a user"
      logger.info user.crypted_password
      logger.info BCrypt::Engine.hash_secret(password,user.salt)
    end
    if user && user.crypted_password == BCrypt::Engine.hash_secret(password,user.salt)
      user
    else
      nil
    end
  end
  
    
  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.crypted_password = BCrypt::Engine.hash_secret(password, self.salt)
    end
  end

end

# == Schema Information
#
# Table name: users
#
#  id                        :integer         not null, primary key
#  login                     :string(255)
#  email                     :string(255)
#  crypted_password          :string(40)
#  salt                      :string(40)
#  created_at                :datetime
#  updated_at                :datetime
#  remember_token            :string(255)
#  remember_token_expires_at :datetime
#  lname                     :string(255)
#  fname                     :string(255)
#  content_type              :string(255)     default("image/png")
#  picture                   :binary
#  title                     :string(255)
#  unit_id                   :integer
#  provider                  :string(255)
#  uid                       :string(255)
#  authorized                :boolean         default(FALSE), not null
#

