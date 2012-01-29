class ChangeShirtSizeToText < ActiveRecord::Migration
  def up
    change_column :campers, :shirt_size, :string
    change_column :campers, :position, :string
    change_column :campers, :media_release, :string
  end

  def down
    change_column :campers, :shirt_size, :integer
    change_column :campers, :position, :integer
    change_column :campers, :media_release, :integer
  end
end
