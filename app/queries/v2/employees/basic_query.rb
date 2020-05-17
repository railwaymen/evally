# frozen_string_literal: true

module V2
  module Employees
    class BasicQuery
      def initialize(scope)
        @scope = scope.includes(:evaluator)
      end

      def call
        @scope
          .select(fields)
          .joins(tables)
          .order(first_name: :asc)
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
              evaluable_id = employees.id AND
                evaluable_type = 'Employee' AND
                state = 'completed'
            ORDER BY completed_at DESC
            LIMIT 1
          ) latest_evaluation ON true
        "
      end
    end
  end
end
