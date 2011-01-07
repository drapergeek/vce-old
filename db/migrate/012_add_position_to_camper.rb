class AddPositionToCamper < ActiveRecord::Migration
  def self.up
    add_column :campers, :position, :integer
  end

  def self.down
    remove_colum :campers, :position
  end
end
