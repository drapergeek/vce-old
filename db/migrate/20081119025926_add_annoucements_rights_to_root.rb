class AddAnnoucementsRightsToRoot < ActiveRecord::Migration
  def self.up
    role = Role.find_by_name('root')
    announce_rights = Array.new
    announce_rights.push(Right.create :name=>'List all annoucements', :controller=>'annoucements', :action=>'index')
    announce_rights.push(Right.create :name=>'Show an individual annoucement', :controller=>'annoucements', :action=>'show')
    announce_rights.push(Right.create :name=>'See the new annoucement page', :controller=>'annoucements', :action=>'new')
    announce_rights.push(Right.create :name=>'Create an annoucement', :controller=>'annoucements', :action=>'create')
    announce_rights.push(Right.create :name=>'See the edit annoucement page', :controller=>'annoucements', :action=>'edit')
    announce_rights.push(Right.create :name=>'Update an annoucement', :controller=>'annoucements', :action=>'update')
    announce_rights.push(Right.create :name=>'Delete an annoucement', :controller=>'annoucements', :action=>'destroy')
    
    announce_rights.each do |r|
      role.rights<<r
    end
  end

  def self.down
  end
end
