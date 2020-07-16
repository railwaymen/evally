class AddLastEvaluationOnToEmployees < ActiveRecord::Migration[6.0]
  def change
    add_column :employees, :last_evaluation_on, :date

    ActiveRecord::Base.transaction do
      Employee.all.map do |employee|
        latest_evaluation = employee.evaluations.completed.order(completed_at: :desc).first

        employee.update!(last_evaluation_on: latest_evaluation&.completed_at)
      end
    end
  end
end
