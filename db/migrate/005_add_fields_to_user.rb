class AddFieldsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :lname, :string
    add_column :users, :fname, :string
    User.reset_column_information
    User.find(:all).each do |u|
      u.update_attribute(:fname, "Empty")
      u.update_attribute(:lname, "Empty")
      
    end
  end

  def self.down
    remove_column :users, :lname
    remove_column :users, :fname
  end
end
