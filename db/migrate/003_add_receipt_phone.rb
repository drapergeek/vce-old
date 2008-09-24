class AddReceiptPhone < ActiveRecord::Migration
  def self.up
    add_column :receipts, :phone, :string
  end

  def self.down
    remove_column :receipts, :phone
  end
end
