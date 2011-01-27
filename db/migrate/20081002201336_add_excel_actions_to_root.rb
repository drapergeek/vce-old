class AddExcelActionsToRoot < ActiveRecord::Migration
  def self.up
    role = Role.find_by_name('root')
    excel_rights = Array.new
    excel_rights.push(Right.create :name=>'Create an excel sheet of all receipts', :controller=>'excel', :action=>'receipts_all')
    excel_rights.push(Right.create :name=>'Create an excel seet of all campers', :controller=>'excel', :action=>'camper_list')
    excel_rights.push(Right.create :name=>'Create an excel sheet of buses', :controller=>'excel', :action=>'bus_list')
    excel_rights.push(Right.create :name=>'Create an excel sheet for all camper info', :controller=>'excel', :action=>'all_camper_info')
    excel_rights.push(Right.create :name=>'Create an excel sheet of campers and their courses', :controller=>'excel', :action=>'camper_classes')
    excel_rights.push(Right.create :name=>'Create an excel sheet of health concerns', :controller=>'excel', :action=>'health_concerns')
    excel_rights.push(Right.create :name=>'Create a custom excel sheet', :controller=>'excel', :action=>'custom_excel')
    excel_rights.push(Right.create :name=>'Output a custom excel sheet', :controller=>'excel', :action=>'create_excel')

    excel_rights.each do |e|
      role.rights<<e
    end
  end

  def self.down
  end
end
