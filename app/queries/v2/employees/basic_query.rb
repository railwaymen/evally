# frozen_string_literal: true

module V2
  module Employees
    class BasicQuery
      def self.call(scope = Employee.all)
        scope.includes(:evaluator).select(fields).joins(tables).order(first_name: :asc)
      end

      def self.fields
        [
          'employees.*',
          'latest_evaluation.completed_at AS latest_evaluation_date'
        ].join(', ')
      end

      def self.tables # rubocop:disable Metrics/MethodLength
        "
          LEFT JOIN LATERAL (
            SELECT
              completed_at
            FROM
              evaluations
            WHERE
              evaluable_id = employees.id AND
                evaluable_type = 'Employee' AND
                state = 'completed'
            ORDER BY completed_at DESC
            LIMIT 1
          ) latest_evaluation ON true
        "
      end

      private_class_method :fields, :tables
    end
  end
end
