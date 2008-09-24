class PaymentInfoShouldBeString < ActiveRecord::Migration
  def self.up
    change_column :receipts, :payment_extra, :string
  end

  def self.down
    change_column :receipts, :payment_extra, :string
  end
end
