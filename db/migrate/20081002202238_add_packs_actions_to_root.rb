class AddPacksActionsToRoot < ActiveRecord::Migration
  def self.up
    role = Role.find_by_name('root')
    pack_rights = Array.new
    pack_rights.push(Right.create :name=>'List all packs', :controller=>'packs', :action=>'index')
    pack_rights.push(Right.create :name=>'List all packs', :controller=>'packs', :action=>'list')
    pack_rights.push(Right.create :name=>'Show a single pack', :controller=>'packs', :action=>'show')
    pack_rights.push(Right.create :name=>'View the new pack screen', :controller=>'packs', :action=>'new')
    pack_rights.push(Right.create :name=>'Create a new pack', :controller=>'packs', :action=>'create')
    pack_rights.push(Right.create :name=>'Show the edit pack screen', :controller=>'packs', :action=>'edit')
    pack_rights.push(Right.create :name=>'Update a pack', :controller=>'packs', :action=>'update')
    pack_rights.push(Right.create :name=>'Delete a pack', :controller=>'packs', :action=>'destroy')
    
    pack_rights.each do |p|
      role.rights<<p
    end
    
  end

  def self.down
  end
end
