class CreateBuses < ActiveRecord::Migration
  def self.up
    create_table :buses do |t|
      t.column :name, :string
      t.column :capacity, :integer
      t.column :info, :text
    end
  end

  def self.down
    drop_table :buses
  end
end
