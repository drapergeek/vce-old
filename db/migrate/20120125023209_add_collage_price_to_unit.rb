class AddCollagePriceToUnit < ActiveRecord::Migration
  def change
    add_column :units, :collage_price, :float
  end
end
