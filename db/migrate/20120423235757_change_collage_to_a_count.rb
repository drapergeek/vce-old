class ChangeCollageToACount < ActiveRecord::Migration
  def up
    add_column :campers, :collage_count, :integer, :default => 0
    remove_column :campers, :collage_purchased

    remove_column :receipts, :camper1_collage, :string
    add_column :receipts, :camper1_collage, :integer, :default => 0

    remove_column :receipts, :camper2_collage, :string
    add_column :receipts, :camper2_collage, :integer, :default => 0

    remove_column :receipts, :camper3_collage, :string
    add_column :receipts, :camper3_collage, :integer, :default => 0
  end

  def down
    remove_column :campers, :collage_count, :integer, :default => 0
    add_column :campers, :collage_purchased, :boolean
    change_column :receipts, :camper1_collage, :boolean
    change_column :receipts, :camper2_collage, :boolean
    change_column :receipts, :camper3_collage, :boolean
  end
end
