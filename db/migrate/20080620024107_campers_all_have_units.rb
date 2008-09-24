class CampersAllHaveUnits < ActiveRecord::Migration
  def self.up
    add_column :campers, :unit_id, :integer
    Camper.find(:all).each do |c| 
      c.update_attribute(:unit_id, 1) 
    end
  end

  def self.down
    remove_column :campers, :unit_id
  end
end
