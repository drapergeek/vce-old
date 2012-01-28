class ChangeGenderToString < ActiveRecord::Migration
  def up
    change_column :campers, :gender, :string
  end

  def down
    change_column :campers, :gender, :integer
  end
end
