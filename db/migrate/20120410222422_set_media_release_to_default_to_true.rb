class SetMediaReleaseToDefaultToTrue < ActiveRecord::Migration
  def up
    change_column :campers, :media_release, :string, :default => 'Yes'
  end

  def down
    change_column :campers, :media_release, :string, :default => nil
  end
end
