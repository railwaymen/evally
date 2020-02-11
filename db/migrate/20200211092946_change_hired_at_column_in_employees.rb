class ChangeHiredAtColumnInEmployees < ActiveRecord::Migration[5.2]
  def up
    change_column :employees, :hired_on, :date
    rename_column :employees, :hired_on, :hired_on
  end

  def down
    rename_column :employees, :hired_on, :hired_on
    change_column :employees, :hired_on, :datetime
  end
end
