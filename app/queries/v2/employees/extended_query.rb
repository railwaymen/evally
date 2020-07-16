# frozen_string_literal: true

module V2
  module Employees
    class ExtendedQuery
      delegate_missing_to :@scope

      def initialize(scope)
        @scope = scope.includes(:evaluator).select(fields)
      end

      private

      def fields # rubocop:disable Metrics/MethodLength
        "
          employees.*,
          EXISTS (
            SELECT 1
            FROM evaluations
            WHERE evaluable_id = employees.id AND evaluable_type = 'Employee'
          ) AS evaluation_exists,
          EXISTS (
            SELECT 1
            FROM evaluations
            WHERE evaluable_id = employees.id AND
              evaluable_type = 'Employee' AND
              state = 'completed'
          ) AS evaluated
        "
      end
    end
  end
end
