class AddUnitToReceipts < ActiveRecord::Migration
  def self.up
    add_column :receipts, :unit_id, :integer
    Receipt.reset_column_information
    Receipt.find(:all).each do |c| 
      c.update_attribute(:unit_id, 1) 
    end 
    
  end

  def self.down
    remove_column :receipts, :unit_id
  end
end
