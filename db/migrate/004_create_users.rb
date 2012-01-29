class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true do |t|
      t.column :login,                     :string
      t.column :email,                     :string
      t.column :crypted_password,          :string
      t.column :salt,                      :string
      t.column :created_at,                :datetime
      t.column :updated_at,                :datetime
      t.column :remember_token,            :string
      t.column :remember_token_expires_at, :datetime
    end
    
    @user = User.new(:password=>'jason', :password_confirmation=>'jason', :email=>'drapersjunk@gmail.com')
    @user.save!
  end

  def self.down
    drop_table "users"
  end
end
