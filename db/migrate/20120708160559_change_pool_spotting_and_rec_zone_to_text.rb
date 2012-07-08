class ChangePoolSpottingAndRecZoneToText < ActiveRecord::Migration
  def up
    change_column :campers, :pool_spotting, :string
    change_column :campers, :rec_zone, :string
  end

  def down
    change_column :campers, :pool_spotting, :integer
    change_column :campers, :rec_zone, :integer
  end
end
