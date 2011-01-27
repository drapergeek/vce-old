class CreateCourseSelections < ActiveRecord::Migration
  def self.up
    create_table :course_selections do |t|
      t.column :camper_id, :integer
      t.column :course_id, :integer
      t.column :preference, :integer
    end
  end

  def self.down
    drop_table :course_selections
  end
end
