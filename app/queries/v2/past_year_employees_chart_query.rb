# frozen_string_literal: true

module V2
  class PastYearEmployeesChartQuery
    def self.call
      ActiveRecord::Base.connection.exec_query(raw_sql).to_a
    end

    def self.raw_sql # rubocop:disable Metrics/MethodLength
      "
        SELECT
          TO_CHAR(hired_on, 'YYYY-MM') AS label,
          COUNT(*) AS value
        FROM
          employees
        WHERE
          hired_on > (hired_on - INTERVAL '1 year') AND
          DATE_PART('month', hired_on) <> DATE_PART('month', CURRENT_DATE)
        GROUP BY
          label
        ORDER BY
          label ASC;
      "
    end

    private_class_method :raw_sql
  end
end

# SELECT
#   t0.*
# FROM
#   GENERATE_SERIES(0, 11) AS n
# LEFT JOIN LATERAL (
#   SELECT
#     TO_CHAR(employees.hired_on - INTERVAL (n || ' months'), 'YYYY-MM') AS label,
#     COUNT(*) AS value
#   FROM
#     employees
#   WHERE
#     TO_CHAR(employees.hired_on, 'YYYY-MM') = label
# ) t0 ON true;
