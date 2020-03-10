# frozen_string_literal: true

module V2
  module Dashboard
    class UpcomingQuery
      def self.call(scope = Employee.all)
        scope.joins(tables).where('drafts.ongoing IS NULL').where.not(state: :archived)
      end

      def self.tables
        "
          LEFT JOIN LATERAL (
            SELECT
              1 AS ongoing
            FROM
              evaluations
            WHERE
              evaluable_id = employees.id AND
                evaluable_type = 'Employee' AND
                state = 'draft'
          ) drafts ON true
        "
      end

      private_class_method :tables
    end
  end
end
