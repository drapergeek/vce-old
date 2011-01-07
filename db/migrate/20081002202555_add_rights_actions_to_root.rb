class AddRightsActionsToRoot < ActiveRecord::Migration
  def self.up
    role = Role.find_by_name('root')
    rights_rights = Array.new
    rights_rights.push(Right.create :name=>'List all rights', :controller=>'rights', :action=>'index')
    rights_rights.push(Right.create :name=>'Show a single right', :controller=>'rights', :action=>'show')
    rights_rights.push(Right.create :name=>'View the new pack screen', :controller=>'rights', :action=>'new')
    rights_rights.push(Right.create :name=>'Create a new right', :controller=>'rights', :action=>'create')
    rights_rights.push(Right.create :name=>'Show the edit right screen', :controller=>'rights', :action=>'edit')
    rights_rights.push(Right.create :name=>'Update a right', :controller=>'rights', :action=>'update')
    rights_rights.push(Right.create :name=>'Delete a right', :controller=>'rights', :action=>'destroy')
    
    rights_rights.each do |r|
      role.rights<<r
    end
  end

  def self.down
  end
end
