class ChangePaymentMethodToString < ActiveRecord::Migration
  def self.up
      change_column :receipts, :payment_method, :string
  end

  def self.down
    change_column :receipts, :payment_method, :integer
  end
end
