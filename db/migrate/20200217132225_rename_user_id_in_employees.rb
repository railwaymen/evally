class RenameUserIdInEmployees < ActiveRecord::Migration[5.2]
  def change
    rename_column :employees, :user_id, :evaluator_id

    Employee.update_all(evaluator_id: nil)
  end
end
