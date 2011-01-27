class AddEmailReceipt < ActiveRecord::Migration
  def self.up
    add_column :receipts, :email, :string
  end

  def self.down
    remove_column :receipts, :email
  end
end
