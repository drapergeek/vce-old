class UsersAllHaveUnits < ActiveRecord::Migration
  def self.up
    add_column :users, :unit_id, :integer
    User.reset_column_information
    User.find(:all).each do |u|
      u.update_attribute(:unit_id, Unit.find(:first).id)
    end
 
  end

  def self.down
    remove_column :users, :unit_id
  end
end
