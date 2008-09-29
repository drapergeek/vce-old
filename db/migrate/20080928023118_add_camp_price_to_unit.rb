class AddCampPriceToUnit < ActiveRecord::Migration
  def self.up
    add_column :units, :camp_price, :float
    Unit.find(:all).each do |u| 
      u.update_attribute(:camp_price, 185.00) 
    end
    
  end

  def self.down
    remove_column :units, :camp_price
  end
end
