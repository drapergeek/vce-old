class Add < ActiveRecord::Migration
  def self.up
    add_column :receipts, :refund_info, :text
  end

  def self.down
    remove_column :receipt, :refund_info
  end
end
