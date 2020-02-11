# frozen_string_literal: true

module V2
  class EmployeesAnalyticsQuery
    def call
      ActiveRecord::Base.connection.exec_query(raw_sql).first
    end

    private

    def raw_sql
      "
        SELECT
          FLOOR(AVG(DATE_PART('day', CURRENT_TIMESTAMP - hired_on::timestamp) / 30)) AS average_employment
        FROM
          employees;
      "
    end
  end
end
