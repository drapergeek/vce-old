class AddCollageToReceipt < ActiveRecord::Migration
  def self.up
    add_column :receipts, :camper1_collage, :boolean
    add_column :receipts, :camper2_collage, :boolean
    add_column :receipts, :camper3_collage, :boolean
  end

  def self.down
      remove_column :receipts, :camper1_collage, :boolean
      remove_column :receipts, :camper2_collage, :boolean
      remove_column :receipts, :camper3_collage, :boolean
  end
end
