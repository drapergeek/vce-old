class AddBusToCamper < ActiveRecord::Migration
  def self.up
    add_column :campers, :bus_id, :integer
  end

  def self.down
    remove_column :campers, :bus_id
  end
end
