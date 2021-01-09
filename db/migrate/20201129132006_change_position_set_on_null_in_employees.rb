class ChangePositionSetOnNullInEmployees < ActiveRecord::Migration[6.0]
  def up
    Employee.update_all("position_set_on = COALESCE(position_set_on, hired_on)")

    change_column_null :employees, :position_set_on, false
  end

  def down
    change_column_null :employees, :position_set_on, true
  end
end
