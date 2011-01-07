class ChangeMediaReleaseToInt < ActiveRecord::Migration
  def self.up
    change_column :campers, :media_release, :integer
  end

  def self.down
    change_column :campers, :media_release, :boolean
  end
end
