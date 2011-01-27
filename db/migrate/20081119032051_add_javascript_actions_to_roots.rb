class AddJavascriptActionsToRoots < ActiveRecord::Migration
  def self.up
    role = Role.find_by_name('root')
    js_rights = Array.new
    js_rights.push(Right.create :name=>'Hide an announcement("SHOULD BE ENABLED FOR ALL USERS")', :controller=>'javascripts', :action=>'hide_announcement')

    js_rights.each do |r|
      role.rights<<r
    end
  end

  def self.down
  end
end
