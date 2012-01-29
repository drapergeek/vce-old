class CreateBasicRolesRightsForCurrentUsers < ActiveRecord::Migration
  def self.up
    role = Role.create :name=>'root' 
    
    User.find(:all).each do |u| 
      u.roles<<role
    end
  end

  def self.down
    
    
  end
end
