require 'digest/sha1'
class User < ActiveRecord::Base
  attr_protected :authorized
  has_many :authentications
  # Virtual attribute for the unencrypted password
  has_many :receipts
  has_and_belongs_to_many :roles
  belongs_to :unit

  validates_presence_of     :login, :email
  validates_length_of       :login,    :within => 3..40
  validates_length_of       :email,    :within => 3..100
  validates_uniqueness_of   :email, :case_sensitive => false
  scope :authorized, where(:authorized=>true)
  scope :unauthorized, where(:authorized=>false)

  def admin?
    login=="gdraper" || login=="ddraper" || login=="bhairston" || login=="lnelson" || login=="user" || login=="draper" 
  end


  def pictureimg=(picture_field) 
    return if picture_field.blank? 
    self.content_type = picture_field.content_type.chomp 
    self.picture = picture_field.read 
  end 
  
  def authorize!
    self.authorized=true
    self.save!
  end
  
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      unless auth["user_info"]["nickname"].blank?
        logger.info "we have a nickname"
        user.login = auth["user_info"]["nickname"]
      else
        logger.info "no nickname"
        user.login = auth["user_info"]["first_name"]+"_"+auth["user_info"]["last_name"]
      end
      user.fname = auth["user_info"]["first_name"]
      user.lname = auth["user_info"]["last_name"]
      user.email = auth["extra"]["user_hash"]["email"]

      logger.info auth.to_yaml
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

