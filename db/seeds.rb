# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
Unit.create!(:name=>"Henry County", :camp_price=>200.00)
User.create!(:login=>"Spiderman", :email=>"spiderman@marvel_test.com", :authorized=>true, :unit_id=>1)
User.find_by_login("Spiderman").authorize!