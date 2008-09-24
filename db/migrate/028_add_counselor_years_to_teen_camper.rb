class AddCounselorYearsToTeenCamper < ActiveRecord::Migration
  def self.up
    add_column :campers, :counselor_years, :integer
  end

  def self.down
    remove_column :campers, :counselor_years
  end
end
