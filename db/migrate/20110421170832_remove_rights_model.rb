class RemoveRightsModel < ActiveRecord::Migration
  def self.up
    drop_table :rights
  end

  def self.down
  end
end
