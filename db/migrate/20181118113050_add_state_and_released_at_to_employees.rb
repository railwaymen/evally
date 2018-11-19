class AddStateAndReleasedAtToEmployees < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :state, :integer, default: 0
    add_column :employees, :released_at, :datetime
  end
end
