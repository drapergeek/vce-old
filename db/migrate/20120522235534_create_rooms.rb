class CreateRooms < ActiveRecord::Migration
  def up
    create_table :rooms do |t|
      t.string :name
      t.integer :pack_id
      t.timestamps
    end

    remove_column  :campers, :pack_id
    remove_column  :campers, :room_number
    add_column :campers, :room_id, :integer
  end

  def down
    drop_table :rooms

    add_column  :campers, :pack_id, :integer
    add_column  :campers, :room_number, :string
    remove_column :campers, :room_id
  end
end
