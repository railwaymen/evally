# frozen_string_literal: true

module V2
  class EmployeesByUsersChartQuery
    def self.call
      ActiveRecord::Base.connection.exec_query(raw_sql).to_a
    end

    def self.raw_sql # rubocop:disable Metrics/MethodLength
      "
        SELECT
          users.first_name || ' ' || users.last_name AS label,
          t1.employees_number AS value
        FROM
          users
        LEFT JOIN LATERAL (
          SELECT
            COUNT (*) AS employees_number
          FROM
            employees
          WHERE
            employees.evaluator_id = users.id
        ) t1 ON true
        WHERE
          users.status = 'active';
      "
    end

    private_class_method :raw_sql
  end
end
