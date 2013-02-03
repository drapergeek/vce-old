class AddExtraFieldsToTeen < ActiveRecord::Migration
  def change
    add_column :campers, :mobile_phone, :string
    add_column :campers, :references_returned, :boolean
    add_column :campers, :picture, :boolean
  end
end
