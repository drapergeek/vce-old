class AddFieldsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :lname, :string
    add_column :users, :fname, :string
  end

  def self.down
    remove_column :users, :lname
    remove_column :users, :fname
  end
end
