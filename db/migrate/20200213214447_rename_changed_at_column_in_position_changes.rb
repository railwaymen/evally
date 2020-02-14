class RenameChangedAtColumnInPositionChanges < ActiveRecord::Migration[5.2]
  def change
    rename_column :position_changes, :changed_at, :changed_on
  end
end
