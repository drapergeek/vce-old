class AddRecZoneToTeens < ActiveRecord::Migration
  def self.up
    add_column :campers, :rec_zone, :integer
  end

  def self.down
    remove_column :campers, :rec_zone, :integer
  end
end
