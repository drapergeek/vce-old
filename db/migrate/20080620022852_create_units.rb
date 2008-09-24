class CreateUnits < ActiveRecord::Migration
  def self.up
    create_table :units do |t|
      t.string :name
      t.timestamps
    end
    Unit.create :name => "Henry County" 
    Unit.create :name => "Franklin County"
    Unit.create :name =>"State Level"
  end

  def self.down
    drop_table :units
  end
end
