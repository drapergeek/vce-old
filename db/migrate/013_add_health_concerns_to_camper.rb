class AddHealthConcernsToCamper < ActiveRecord::Migration
  def self.up
    add_column :campers, :health_concerns, :text
  end

  def self.down
    remove_column :campers, :health_concerns
  end
end
