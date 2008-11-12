class AddUserRights < ActiveRecord::Migration
  def self.up
    role = Role.find_by_name('root')
    user_rights = Array.new
    user_rights.push(Right.create :name=>'Show all users', :controller=>'account', :action=>'index')
    user_rights.push(Right.create :name=>'Delete a user', :controller=>'account', :action=>'destroy')
    user_rights.push(Right.create :name=>'View user signatures(should be allowed for all users', :controller=>'account', :action=>'image')
    user_rights.push(Right.create :name=>'Log in to the system(should be allowed for all users)', :controller=>'account', :action=>'login')
    user_rights.push(Right.create :name=>'Log out of the system(should be allowed for all users)', :controller=>'account', :action=>'logout')
    user_rights.push(Right.create :name=>'Register a new user', :controller=>'account', :action=>'signup')    
    user_rights.push(Right.create :name=>'Edit their own profile(should be allowed for all users)', :controller=>'account', :action=>'edit')    
    user_rights.push(Right.create :name=>'Edit other users', :controller=>'account', :action=>'edit_another_user')    
    user_rights.push(Right.create :name=>'Update their own profile(should be allowed for all users)', :controller=>'account', :action=>'update')
 
    user_rights.each do |c|
      role.rights<<c
    end
  end

  def self.down
  end
end
