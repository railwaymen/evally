class AddGroupToEmployees < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :group, :string, default: 'Unassigned'
    add_index :employees, :group
  end
end
