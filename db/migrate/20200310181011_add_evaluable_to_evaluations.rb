class AddEvaluableToEvaluations < ActiveRecord::Migration[6.0]
  def change
    remove_index :evaluations, :employee_id
    rename_column :evaluations, :employee_id, :evaluable_id

    add_column :evaluations, :evaluable_type, :string, null: false, default: 'Employee'
    change_column_default :evaluations, :evaluable_type, from: 'Employee', to: nil

    add_index :evaluations, [:evaluable_type, :evaluable_id]
  end
end
