require 'digest/sha1'
class User < ActiveRecord::Base
  has_many :authentications
  # Virtual attribute for the unencrypted password
  has_many :receipts
  has_and_belongs_to_many :roles
  belongs_to :unit

  validates_presence_of     :login, :email
  validates_length_of       :login,    :within => 3..40
  validates_length_of       :email,    :within => 3..100
  validates_uniqueness_of   :login, :email, :case_sensitive => false

  def admin?
    login=="gdraper" || login=="ddraper" || login=="bhairston" || login=="lnelson" || login=="user" || login=="draper" 
  end


  def pictureimg=(picture_field) 
    return if picture_field.blank? 
    self.content_type = picture_field.content_type.chomp 
    self.picture = picture_field.read 
  end 
  

end
