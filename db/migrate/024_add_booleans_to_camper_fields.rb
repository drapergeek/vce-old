class AddBooleansToCamperFields < ActiveRecord::Migration
  def self.up
  	add_column :campers, :reference, :boolean
  	#personal_information
  	
  	add_column :campers, :physician_insurance_info, :boolean
  	#health
  	add_column :campers, :emergency_info, :boolean
  	#health
  	add_column :campers, :immunizations_current, :boolean
  	#health
  	
  	add_column :campers, :release_authorization, :boolean
  	#other_info
  	add_column :campers, :parental_signatures, :boolean
  	#other_info
  end

  def self.down
    remove_column :campers, :reference
  	remove_column :campers, :physician_insurance_info
  	remove_column :campers, :emergency_info
  	remove_column :campers, :immunizations_current
  	remove_column :campers, :release_authorization
  	remove_column :campers, :parental_signatures
  end
end
