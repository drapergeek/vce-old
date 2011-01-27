class CreateAnnoucements < ActiveRecord::Migration
  def self.up
    create_table :annoucements do |t|
      t.timestamp :created_at
      t.timestamp :updated_at
      t.text :message
      t.datetime :starts_at
      t.datetime :ends_at

      t.timestamps
    end
  end

  def self.down
    drop_table :annoucements
  end
end
