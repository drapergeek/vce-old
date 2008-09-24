class AddPaymentNumberToCamper < ActiveRecord::Migration
  def self.up
    add_column :campers, :payment_number, :string
  end

  def self.down
    remove_column :campers, :payment_number
  end
end
