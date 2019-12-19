# frozen_string_literal: true

module V2
  class EmployeesQuery
    def self.call(scope = Employee.all)
      scope.select(fields).joins(tables)
    end

    def self.fields
      [
        'employees.*',
        'latest_evaluation.completed_at AS latest_evaluation_date'
      ].join(', ')
    end

    private_class_method :fields

    def self.tables # rubocop:disable Metrics/MethodLength
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

    private_class_method :tables
  end
end
