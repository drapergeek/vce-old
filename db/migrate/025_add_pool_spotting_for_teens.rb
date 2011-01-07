class AddPoolSpottingForTeens < ActiveRecord::Migration
  def self.up
    add_column :campers, :pool_spotting, :integer
  end

  def self.down
    remove_column :campers, :pool_spotting, :integer
  end
end
