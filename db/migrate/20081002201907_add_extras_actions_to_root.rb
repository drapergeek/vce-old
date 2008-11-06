class AddExtrasActionsToRoot < ActiveRecord::Migration
  def self.up
    role = Role.find_by_name('root')
    extra_rights = Array.new
    extra_rights.push(Right.create :name=>'Show the extras available', :controller=>'extras', :action=>'index')
    extra_rights.push(Right.create :name=>'List campers by year', :controller=>'extras', :action=>'list_campers_by_year')
    extra_rights.push(Right.create :name=>'Show camper demographics', :controller=>'extras', :action=>'demographics')

    extra_rights.each do |e|
      role.rights<<e
    end
  end

  def self.down
  end
end
