class AddRefundToReceipt < ActiveRecord::Migration
  def self.up
    add_column :receipts, :refund, :boolean
    add_column :receipts, :refund_date, :timestamp
    add_column :receipts, :refund_check_number, :integer
    add_column :receipts, :refund_amount, :float
  end

  def self.down
    remove_column :receipts, :refund, :boolean
    remove_column :receipts, :refund_date, :timestamp
    remove_column :rremoveipts, :refund_check_number, :integer
    remove_column :receipts, :refund_amount, :float
  end
end
