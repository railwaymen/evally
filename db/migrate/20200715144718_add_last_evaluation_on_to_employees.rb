class AddLastEvaluationOnToEmployees < ActiveRecord::Migration[6.0]
  def change
    add_column :employees, :last_evaluation_on, :date

    ActiveRecord::Base.transaction do
      V2::Employees::ExtendedQuery.new(Employee.all).map do |employee|
        employee.update!(last_evaluation_on: employee.latest_evaluation_date)
      end
    end
  end
end
