class AddRolesActionsToRoot < ActiveRecord::Migration
  def self.up
    role = Role.find_by_name('root')
    roles_rights = Array.new
    roles_rights.push(Right.create :name=>'List all roles', :controller=>'roles', :action=>'index')
    roles_rights.push(Right.create :name=>'Show a single role', :controller=>'roles', :action=>'show')
    roles_rights.push(Right.create :name=>'View the new role screen', :controller=>'roles', :action=>'new')
    roles_rights.push(Right.create :name=>'Create a new role', :controller=>'roles', :action=>'create')
    roles_rights.push(Right.create :name=>'Show the edit right screen', :controller=>'roles', :action=>'edit')
    roles_rights.push(Right.create :name=>'Update a role', :controller=>'roles', :action=>'update')
    roles_rights.push(Right.create :name=>'Delete a role', :controller=>'roles', :action=>'destroy')
    
    roles_rights.each do |r|
      role.rights<<r
    end
  end

  def self.down
  end
end
