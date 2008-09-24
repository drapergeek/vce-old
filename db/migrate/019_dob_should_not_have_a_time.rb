class DobShouldNotHaveATime < ActiveRecord::Migration
  def self.up
    change_column :campers, :dob, :date
  end

  def self.down
    change_column :campers, :dob, :timedate
  end
end
