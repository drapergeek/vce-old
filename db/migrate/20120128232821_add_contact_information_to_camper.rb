class AddContactInformationToCamper < ActiveRecord::Migration
  def change
    add_column :campers, :mother_name, :string
    add_column :campers, :mother_phone, :string
    add_column :campers, :mother_email, :string
    add_column :campers, :father_name, :string
    add_column :campers, :father_phone, :string
    add_column :campers, :father_email, :string
    add_column :campers, :guardian_name, :string
    add_column :campers, :guardian_phone, :string
    add_column :campers, :guardian_email, :string
  end
end
