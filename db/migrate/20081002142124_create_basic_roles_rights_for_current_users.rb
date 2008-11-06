class CreateBasicRolesRightsForCurrentUsers < ActiveRecord::Migration
  def self.up
    role = Role.create :name=>'Root'
    #Create all the rights
    receipt_rights = Array.new
    receipt_rights.push(Right.create :name=>'Show Individual Receipts', :controller=>'receipts', :action=>'show')
    receipt_rights.push(Right.create :name=>'List All Receipts', :controller=>'receipts', :action=>'index')
    receipt_rights.push(Right.create :name=>'Show Receipt Totals', :controller=>'receipts', :action=>'totals')
    receipt_rights.push(Right.create :name=>'Search For Receipts', :controller=>'receipts', :action=>'search')
    receipt_rights.push(Right.create :name=>'List Receipt Totals By Date', :controller=>'receipts', :action=>'list_by_date')
    receipt_rights.push(Right.create :name=>'Show Receipts By Date', :controller=>'receipts', :action=>'show_by_date')
    receipt_rights.push(Right.create :name=>'Show Form For Creating New Receipts', :controller=>'receipts', :action=>'new')
    receipt_rights.push(Right.create :name=>'Create New Receipts', :controller=>'receipts', :action=>'new')
    receipt_rights.push(Right.create :name=>'Edit Receipts', :controller=>'receipts', :action=>'edit')
    receipt_rights.push(Right.create :name=>'Update Receipts', :controller=>'receipts', :action=>'update')
    receipt_rights.push(Right.create :name=>'Delete Receipts', :controller=>'receipts', :action=>'destroy')
    
    receipt_rights.each do |r|
      role.rights<<r
    end

    bus_rights = Array.new
    bus_rights.push(Right.create :name=>'List All Buses', :controller=>'buses', :action=>'index')
    bus_rights.push(Right.create :name=>'List All Buses', :controller=>'buses', :action=>'list')
    bus_rights.push(Right.create :name=>'Show Individual Buses', :controller=>'buses', :action=>'show')
    bus_rights.push(Right.create :name=>'View Available Campers For Buses', :controller=>'buses', :action=>'add_campers')
    bus_rights.push(Right.create :name=>'Add Campers to Buses', :controller=>'buses', :action=>'add_camper_to_bus')
    bus_rights.push(Right.create :name=>'Show Form for new Campers', :controller=>'buses', :action=>'new')
    bus_rights.push(Right.create :name=>'Create New Camper', :controller=>'buses', :action=>'create')
    bus_rights.push(Right.create :name=>'Remove Campers from a bus', :controller=>'buses', :action=>'remove_camper')
    bus_rights.push(Right.create :name=>'Show the screen for editing a bus', :controller=>'buses', :action=>'edit' )
    bus_rights.push(Right.create :name=>'Update Bus Information', :controller=>'buses', :action=>'update')
    bus_rights.push(Right.create :name=>'Delete a Bus', :controller=>'buses', :action=>'destroy')
    
    bus_rights.each do |b|
      role.rights<<b
    end
    
    
    
    
    User.find(:all).each do |u| 
      u.roles<<role
    end
  end

  def self.down
    
    
  end
end
