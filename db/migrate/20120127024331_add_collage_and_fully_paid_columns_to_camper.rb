class AddCollageAndFullyPaidColumnsToCamper < ActiveRecord::Migration
  def change
    add_column :campers, :collage_purchased, :boolean
    add_column :campers, :fully_paid, :boolean
  end
end
