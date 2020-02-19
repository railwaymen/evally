# frozen_string_literal: true

module V2
  class EmployeesAnalyticsQuery
    def self.call
      ActiveRecord::Base.connection.exec_query(raw_sql).first
    end

    def self.raw_sql # rubocop:disable Metrics/MethodLength
      "
        SELECT
          COALESCE(
            FLOOR(
              AVG(
                DATE_PART('day', CURRENT_TIMESTAMP - hired_on::timestamp) / 30
              )
            ), 0
          ) AS average_employment
        FROM
          employees;
      "
    end

    private_class_method :raw_sql
  end
end
