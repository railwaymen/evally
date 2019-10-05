class AddPositionSetAtToEmployees < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :position_set_at, :date
  end
end
