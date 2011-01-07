class MakeCampersInactive < ActiveRecord::Migration
  def self.up
     add_column :campers, :inactive, :boolean
     add_column :campers, :inactive_info, :text
  end

  def self.down
     remove_column :campers, :inactive
     remove_column :campers, :inactive_info
  end
end
