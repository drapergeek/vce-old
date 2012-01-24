class AddPaymentAmountToEachCamper < ActiveRecord::Migration
  def change
    add_column :receipts, :camper1_payment, :float
    add_column :receipts, :camper2_payment, :float
    add_column :receipts, :camper3_payment, :float
  end
end
