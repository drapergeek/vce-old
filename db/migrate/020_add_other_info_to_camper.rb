class AddOtherInfoToCamper < ActiveRecord::Migration
  def self.up
    add_column :campers, :email, :string
    add_column :campers, :race, :string
    add_column :campers, :last_tetnus_shot, :date
    add_column :campers, :code_of_conduct, :boolean
    add_column :campers, :media_release, :string
    add_column :campers, :equine_release, :boolean
  end

  def self.down
    remove_column :campers, :email
    remove_column :campers, :race
    remove_column :campers, :last_tetnus_shot
    remove_column :campers, :code_of_conduct
    remove_column :campers, :media_release
    remove_column :campers, :equine_release
    
  end
end
