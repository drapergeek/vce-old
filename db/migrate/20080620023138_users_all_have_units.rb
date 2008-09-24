class UsersAllHaveUnits < ActiveRecord::Migration
  def self.up
    add_column :users, :unit_id, :integer
    User.find(:all).each do |c| 
      c.update_attribute(:unit_id, 1) 
    end 
 
  end

  def self.down
    remove_column :users, :unit_id
  end
end
