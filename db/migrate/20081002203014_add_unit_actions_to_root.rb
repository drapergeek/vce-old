class AddUnitActionsToRoot < ActiveRecord::Migration
  def self.up
    role = Role.find_by_name('root')
    units_rights = Array.new
    units_rights.push(Right.create :name=>'List all units', :controller=>'units', :action=>'index')
    units_rights.push(Right.create :name=>'Show a single unit', :controller=>'units', :action=>'show')
    units_rights.push(Right.create :name=>'View the new unit screen', :controller=>'units', :action=>'new')
    units_rights.push(Right.create :name=>'Create a new unit', :controller=>'units', :action=>'create')
    units_rights.push(Right.create :name=>'Show the edit right screen', :controller=>'units', :action=>'edit')
    units_rights.push(Right.create :name=>'Update a unit', :controller=>'units', :action=>'update')
    units_rights.push(Right.create :name=>'Delete a unit', :controller=>'units', :action=>'destroy')
    
    units_rights.each do |r|
      role.rights<<r
    end
    
    
    
    
    
    
    
    
    
    
    
  end

  def self.down
  end
end
