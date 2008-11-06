class CreateUnits < ActiveRecord::Migration
  def self.up
    create_table :units do |t|
      t.string :name
      t.timestamps
      t.float    :camp_price
    end
    Unit.create :name => "Henry County", :camp_price=>185.00
    Unit.create :name => "Franklin County", :camp_price=>185.00
    Unit.create :name =>"State Level", :camp_price=>185.00
  end

  def self.down
    drop_table :units
  end
end
