# frozen_string_literal: true

module V2
  class EmployeesQuery
    def initialize(scope = Employee.all)
      @scope = scope
    end

    def call
      @scope.select(fields).joins(tables)
    end

    private

    def fields
      [
        'employees.*',
        'latest_evaluation.completed_at AS latest_evaluation_date'
      ].join(', ')
    end

    def tables # rubocop:disable Metrics/MethodLength
      "
        LEFT JOIN LATERAL (
          SELECT
            completed_at
          FROM
            evaluations
          WHERE
            employee_id = employees.id AND state = 'completed'
          ORDER BY completed_at DESC
          LIMIT 1
        ) latest_evaluation ON true
      "
    end
  end
end
