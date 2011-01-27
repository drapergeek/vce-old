class AddNewReportsToRights < ActiveRecord::Migration
  def self.up
    role = Role.find_by_name('root')
    units_rights = Array.new
    units_rights.push(Right.create :name=>'Show unpaid camper excel sheet', :controller=>'excel', :action=>'unpaid_campers')
    units_rights.each do |r|
      role.rights<<r
    end
  end

  def self.down
  end
end
