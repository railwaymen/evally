class RenamePositionSetAtColumnInEmployees < ActiveRecord::Migration[5.2]
  def change
    rename_column :employees, :position_set_at, :position_set_on
  end
end
