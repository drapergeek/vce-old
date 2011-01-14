class AddAuthorizedToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :authorized, :boolean, :default=>false, :null=>false
  end

  def self.down
    remove_column :users, :authorized
  end
end
