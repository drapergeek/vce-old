class AddRoomNameToPack < ActiveRecord::Migration
  def self.up
    add_column :packs, :building_initials, :string
    add_column :packs, :building_name, :string
    add_column :packs, :room_number_beginning, :integer
    add_column :packs, :room_number_ending, :integer
    Pack.reset_column_information
    Pack.find(:all).each do |p| 
        p.update_attribute(:building_initials, "NA")
        p.update_attribute(:building_name, "Not Assigned")
        p.update_attribute(:room_number_ending, 0)
        p.update_attribute(:room_number_beginning, 0)
    end
  end

  def self.down
    remove_column :packs, :building_initials
    remove_column :packs, :building_name
    remove_column :packs, :room_number_beginning 
    remove_column :packs, :room_number_ending
  end
end
