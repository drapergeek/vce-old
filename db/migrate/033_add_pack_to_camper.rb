class AddPackToCamper < ActiveRecord::Migration
  def self.up
    add_column :campers, :pack_id, :integer
  end

  def self.down
    remove_column :campers, :pack_id, :integer
  end
end
