class AddRoomNumberToCamperAndChangeMediaReleaseToBoolean < ActiveRecord::Migration
  def self.up
    add_column :campers, :room_number, :string
  end

  def self.down
    remove_column :campers, :room_number
  end
end
