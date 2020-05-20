# frozen_string_literal: true

module V2
  module Dashboard
    class UpcomingQuery
      def initialize(scope)
        @scope = scope
      end

      def call
        @scope
          .joins(tables)
          .where("drafts.ongoing IS NULL AND state != 'archived'")
          .order(next_evaluation_on: :asc)
      end

      private

      def tables # rubocop:disable Metrics/MethodLength
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
    end
  end
end
