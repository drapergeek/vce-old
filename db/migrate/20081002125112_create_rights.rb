class CreateRights < ActiveRecord::Migration
  def self.up
    
    create_table :roles_users, :id=>:false   do |t|
      t.column :role_id, :integer
      t.column :user_id, :integer
    end
    remove_column :roles_users, :id
    
    
    create_table :roles do |t|
      t.column :name, :string
    end
    
    
    create_table :rights_roles, :id=>:false do |t|
      t.column :right_id, :integer
      t.column :role_id, :integer
    end
    remove_column :rights_roles, :id
    
    create_table :rights do |t|
      t.column :name, :string
      t.column :controller, :string
      t.column :action, :string
    end
    

  end

  def self.down
    drop_table :rights
    drop_table :roles
    drop_table :rights_roles
    drop_table :roles_users
  end
end
