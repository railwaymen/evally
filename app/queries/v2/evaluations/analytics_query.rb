# frozen_string_literal: true

module V2
  module Evaluations
    class AnalyticsQuery
      def self.call
        ActiveRecord::Base.connection.exec_query(raw_sql).first
      end

      def self.raw_sql # rubocop:disable Metrics/MethodLength
        "
          SELECT
            ROUND (
              AVG (t0.employee_evaluations_number) FILTER (
                WHERE employees.state = 'hired'
              ), 2
            )::float AS average_evaluations,
            t1.*
          FROM
            employees
          LEFT JOIN LATERAL (
            SELECT
              COUNT (*) AS employee_evaluations_number
            FROM
              evaluations
            WHERE
              evaluations.employee_id = employees.id AND
                evaluations.state = 'completed' AND
                evaluations.completed_at IS NOT NULL
          ) t0 ON true
          LEFT JOIN LATERAL (
            SELECT
              COUNT (*) FILTER (
                WHERE evaluations.state = 'completed'
              ) AS total_evaluations_number,
              COUNT (*) FILTER (
                WHERE
                  evaluations.state = 'completed' AND
                    DATE_PART('year', evaluations.completed_at) = DATE_PART('year', CURRENT_DATE)
              ) AS evaluations_number_this_year
            FROM
              evaluations
          ) t1 ON true
          GROUP BY t1.total_evaluations_number, t1.evaluations_number_this_year;
        "
      end

      private_class_method :raw_sql
    end
  end
end
