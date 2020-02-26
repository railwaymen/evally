# frozen_string_literal: true

module V2
  class EmployeesAnalyticsQuery
    def self.call
      ActiveRecord::Base.connection.exec_query(raw_sql).first
    end

    # rubocop:disable Metrics/MethodLength, Layout/LineLength
    def self.raw_sql
      "
      SELECT
        COUNT (*) FILTER (
          WHERE state = 'hired'
        ) AS hired_employees_number,
        COUNT (*) FILTER (
          WHERE state = 'archived'
        ) AS archived_employees_number,
        COUNT (*) FILTER (
          WHERE DATE_PART('year', hired_on) = DATE_PART('year', CURRENT_DATE)
        ) AS new_employees_number_this_year,
        COUNT (*) FILTER (
          WHERE DATE_PART('year', archived_on) = DATE_PART('year', CURRENT_DATE)
        ) AS archived_employees_number_this_year,
        t0.average_employment_in_months
      FROM
        employees
      LEFT JOIN LATERAL (
        SELECT
          COALESCE(
            FLOOR(
              AVG(
                DATE_PART('day', COALESCE(archived_on::timestamp, CURRENT_TIMESTAMP) - hired_on::timestamp) / 30
              )
            ), 0
          ) AS average_employment_in_months
        FROM
          employees
      ) t0 ON true
      GROUP BY t0.average_employment_in_months;
      "
    end
    # rubocop:enable Metrics/MethodLength, Layout/LineLength

    private_class_method :raw_sql
  end
end
