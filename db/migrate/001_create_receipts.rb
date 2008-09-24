class CreateReceipts < ActiveRecord::Migration
  def self.up
    create_table :receipts do |t|
      t.column :date, :timestamp
      t.column :fname, :string
      t.column :lname, :string
      t.column :address, :string
      t.column :state, :string
      t.column :zip, :int
      t.column :city, :string
      t.column :amount, :float
      t.column :payment_method, :integer
      t.column :payment_extra, :integer
      t.column :camper1, :string
      t.column :camper1_id, :string
      t.column :camper2, :string
      t.column :camper2_id, :string
      t.column :camper3, :string
      t.column :camper3_id, :string
      t.column :account_id, :integer
      t.column :user_id, :integer
    end
  end

  def self.down
    drop_table :receipts
  end
end
