class AddPhotoColumn < ActiveRecord::Migration 
  def self.up 
    add_column :users, :content_type, :string, :default => "image/png" 
    execute 'ALTER TABLE users ADD COLUMN picture LONGBLOB' 
  end 
  
  def self.down 
    remove_column :users, :content_type 
    remove_column :users, :picture 
  end 
end 
