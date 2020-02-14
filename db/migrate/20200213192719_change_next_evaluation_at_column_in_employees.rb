class ChangeNextEvaluationAtColumnInEmployees < ActiveRecord::Migration[5.2]
  def up
    change_column :employees, :next_evaluation_at, :date
    rename_column :employees, :next_evaluation_at, :next_evaluation_on
  end

  def down
    rename_column :employees, :next_evaluation_on, :next_evaluation_at
    change_column :employees, :next_evaluation_at, :datetime
  end
end
