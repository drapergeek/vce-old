class AddCreatedToCourses < ActiveRecord::Migration
  def self.up
    add_column :courses, :created_at, :datetime
  end

  def self.down
    remove_colum  :courses, :created_at, :datetime
  end
end
