class AddCreatedAtToReceipt < ActiveRecord::Migration
  def self.up
    add_column :receipts, :created_at, :timestamp
  end

  def self.down
    remove_column :receipts, :created_at, :timestamp
  end
end
