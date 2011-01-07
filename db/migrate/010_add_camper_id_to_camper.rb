class AddCamperIdToCamper < ActiveRecord::Migration
  def self.up
    add_column :campers, :number, :string
  end

  def self.down
    remove_column :campers, :number
  end
end
