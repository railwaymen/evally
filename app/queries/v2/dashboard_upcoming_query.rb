# frozen_string_literal: true

module V2
  class DashboardUpcomingQuery
    def self.call(scope = Employee.all)
      scope.joins(tables).where('drafts.ongoing IS NULL')
    end

    def self.tables
      "
        LEFT JOIN LATERAL (
          SELECT
            1 AS ongoing
          FROM
            evaluations
          WHERE
            employee_id = employees.id AND state = 'draft'
        ) drafts ON true
      "
    end

    private_class_method :tables
  end
end
