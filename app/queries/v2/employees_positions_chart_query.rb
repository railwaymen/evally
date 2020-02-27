# frozen_string_literal: true

module V2
  class EmployeesPositionsChartQuery
    def self.call
      ActiveRecord::Base.connection.exec_query(raw_sql).to_a
    end

    def self.raw_sql # rubocop:disable Metrics/MethodLength
      "
        SELECT
          \"group\",
          position AS label,
          COUNT(position) AS value
        FROM
          employees
        WHERE state = 'hired'
        GROUP BY
          \"group\",
          position
        ORDER BY \"group\" ASC;
      "
    end

    private_class_method :raw_sql
  end
end
