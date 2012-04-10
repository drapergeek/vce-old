class SetMediaReleaseToDefaultToTrue < ActiveRecord::Migration
  def up
    change_column :campers, :media_release, :string, :default => 'yes'
  end

  def down
    raise ActiveRecord::IrreversibleMigration, "Can't remove the default"
  end
end
