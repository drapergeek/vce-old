class AddCamperRightsToRoot < ActiveRecord::Migration
  def self.up
    role = Role.find_by_name('root')
    
    campers_rights = Array.new
    campers_rights.push(Right.create :name=>'List All Campers', :controller=>'campers', :action=>'index')
    campers_rights.push(Right.create :name=>'List All Campers', :controller=>'campers', :action=>'list')
    campers_rights.push(Right.create :name=>'Search for campers', :controller=>'campers', :action=>'search')
    campers_rights.push(Right.create :name=>'Update Camper Fields', :controller=>'campers', :action=>'update_camper_fields')
    campers_rights.push(Right.create :name=>'Add a course to a camper', :controller=>'campers', :action=>'add_course')
    campers_rights.push(Right.create :name=>'Remove a course from a camper', :controller=>'campers', :action=>'remove_course')
    campers_rights.push(Right.create :name=>'Show An Individual Camper', :controller=>'campers', :action=>'show')
    campers_rights.push(Right.create :name=>'Find a Camper', :controller=>'campers', :action=>'find')
    campers_rights.push(Right.create :name=>'Show the new camper form', :controller=>'campers', :action=>'new')
    campers_rights.push(Right.create :name=>'Create a new camper', :controller=>'campers', :action=>'create')
    campers_rights.push(Right.create :name=>'Show the camper edit screen', :controller=>'campers', :action=>'edit')
    campers_rights.push(Right.create :name=>'Update a camper', :controller=>'campers', :action=>'update')
    campers_rights.push(Right.create :name=>'Delete a camper', :controller=>'campers', :action=>'destroy')
    campers_rights.push(Right.create :name=>'List Inactive Campers', :controller=>'campers', :action=>'list_inactive')
    campers_rights.push(Right.create :name=>'List Campers By Type', :controller=>'campers', :action=>'list_camper_type')
    
    campers_rights.each do |c|
      role.rights<<c
    end
    
    
  end

  def self.down

  end
end
