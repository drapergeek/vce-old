class PacksCoursesBusesHaveUnitsToo < ActiveRecord::Migration
  def self.up
     add_column :packs, :unit_id, :integer
     add_column :buses, :unit_id, :integer
     add_column :courses, :unit_id, :integer
      Pack.find(:all).each do |c| 
        c.update_attribute(:unit_id, 1) 
      end 
      Course.find(:all).each do |c| 
        c.update_attribute(:unit_id, 1) 
      end
      Bus.find(:all).each do |c| 
        c.update_attribute(:unit_id, 1) 
      end
      
    
  end

  def self.down
    remove_column :packs, :unit_id
    remove_column :courses, :unit_id
    remove_column :buses, :unit_id
  end
end
