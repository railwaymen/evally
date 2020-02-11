class ChangeHiredAtColumnInEmployees < ActiveRecord::Migration[5.2]
  def up
    change_column :employees, :hired_at, :date
    rename_column :employees, :hired_at, :hired_on
  end

  def down
    rename_column :employees, :hired_on, :hired_at
    change_column :employees, :hired_at, :datetime
  end
end
