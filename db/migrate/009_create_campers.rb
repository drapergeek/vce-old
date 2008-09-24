class CreateCampers < ActiveRecord::Migration
  def self.up
    create_table :campers do |t|
      t.column :created_at, :timestamp
      t.column :updated_at, :timestamp
      t.column :fname, :string
      t.column :lname, :string
      t.column :mname, :string
      t.column :pref_name, :string
      t.column :dob, :date
      t.column :gender, :integer
      t.column :address, :string
      t.column :city, :string
      t.column :state, :string
      t.column :zip, :integer
      t.column :roomate_choice, :string
      t.column :parent_lname, :string
      t.column :parent_fname, :string
      t.column :phone1, :string
      t.column :phone2, :string
      t.column :emergency_name, :string
      t.column :emergency_phone, :string
      t.column :school, :string
      t.column :teacher, :string
      t.column :grade, :int
      t.column :shirt_size, :int
    end
  end

  def self.down
    drop_table :campers
  end
end
