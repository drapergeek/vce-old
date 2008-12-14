class AddDefaultUserRole < ActiveRecord::Migration
  def self.up
    role = Role.new(:name=>"default")
    rights = Array.new
    rights.push(Right.find_by_controller_and_action("account", "image"))
    rights.push(Right.find_by_controller_and_action("account", "login"))
    rights.push(Right.find_by_controller_and_action("account", "logout"))
    rights.push(Right.find_by_controller_and_action("account", "edit"))
    rights.push(Right.find_by_controller_and_action("account", "update"))
    rights.push(Right.find_by_controller_and_action("javascripts", "hide_announcement"))
    rights.push(Right.find_by_controller_and_action("receipts", "index"))
     rights.each do |r|
        role.rights<<r
      end
      
      role.save!
  end

  def self.down
    Role.find_by_name("default").destroy
  end
end
