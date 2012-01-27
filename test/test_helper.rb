ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  #fixtures :all

  # Add more helper methods to be used by all tests here...
  
  def login
    unit = Unit.create(:name=>"Henry County", :camp_price=>30.00)
    u = User.new(:email=>"spiderman@marvel.com")
    u.unit = unit
    u.authorize!
    u.save(:validate=>false)
    role = Role.find_or_create_by_name("admin")
    u.roles << role 
    u.save(:validate=>false)
    session[:user_id] = u.id
  end
  
  def setup
   # load "#{Rails.root}/db/seeds.rb"
    
  end
end
