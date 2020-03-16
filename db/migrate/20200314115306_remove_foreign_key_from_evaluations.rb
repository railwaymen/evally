class RemoveForeignKeyFromEvaluations < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :evaluations, :employees, column: :evaluable_id
  end
end
