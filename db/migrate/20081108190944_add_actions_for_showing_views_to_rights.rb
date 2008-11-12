class AddActionsForShowingViewsToRights < ActiveRecord::Migration
  def self.up
      role = Role.find_by_name('root')
      view_rights = Array.new
      view_rights.push(Right.create :name=>'Show the receipts button', :controller=>'receipts', :action=>'show_receipts_button')
      view_rights.push(Right.create :name=>'Show the campers button', :controller=>'campers', :action=>'show_campers_button')
      view_rights.push(Right.create :name=>'Show the courses button', :controller=>'courses', :action=>'show_courses_button')
      view_rights.push(Right.create :name=>'Show the packs button', :controller=>'packs', :action=>'show_packs_button')
      view_rights.push(Right.create :name=>'Show the buses button', :controller=>'buses', :action=>'show_buses_button')
      view_rights.push(Right.create :name=>'Show the users button', :controller=>'account', :action=>'show_users_button')
      view_rights.push(Right.create :name=>'Show the extras button', :controller=>'extras', :action=>'show_extras_button')
      
      view_rights.push(Right.create :name=>'Show the camper statistics for your unit', :controller=>'statistics', :action=>'receipts')
      
      view_rights.push(Right.create :name=>'Show the camper statistics for your unit', :controller=>'statistics', :action=>'campers')
      view_rights.push(Right.create :name=>'Show the course statistics for your unit', :controller=>'statistics', :action=>'courses')        
      view_rights.each do |c|
        role.rights<<c
      end
  end

  def self.down
  end
end
