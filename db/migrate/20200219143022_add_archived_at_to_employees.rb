class AddArchivedAtToEmployees < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :archived_on, :date
  end
end
