class CreateStates < ActiveRecord::Migration
  def self.up
    create_table :states do |t|
      t.column :name, :string
    end
    State.create :name=>'VA'
    State.create :name=>'NC'
  end

  def self.down
    drop_table :states
  end
end
