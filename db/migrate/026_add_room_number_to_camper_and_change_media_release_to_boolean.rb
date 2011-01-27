class AddRoomNumberToCamperAndChangeMediaReleaseToBoolean < ActiveRecord::Migration
  def self.up
    add_column :campers, :room_number, :string
    change_column :campers, :media_release, :boolean
  end

  def self.down
    remove_column :campers, :room_number
    change_column :campers, :media_release, :integer
  end
end
