class AddArchivedAtToEmployees < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :archived_at, :datetime
  end
end
