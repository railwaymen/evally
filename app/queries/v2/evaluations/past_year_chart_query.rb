# frozen_string_literal: true

module V2
  module Evaluations
    class PastYearChartQuery
      def self.call
        ActiveRecord::Base.connection.exec_query(raw_sql).to_a
      end

      # rubocop:disable Metrics/MethodLength, Layout/LineLength
      def self.raw_sql
        "
          SELECT
            TO_CHAR(t0.month::date, 'YYYY-MM-01') AS label,
            t1.value AS value
          FROM
            GENERATE_SERIES(CURRENT_DATE - INTERVAL '11 months', CURRENT_DATE, INTERVAL '1 month') AS t0(month)
          LEFT JOIN LATERAL (
            SELECT
              COUNT(*) AS value
            FROM
              evaluations
            WHERE
              evaluations.state = 'completed' AND
                TO_CHAR(t0.month::date, 'YYYY-MM') = TO_CHAR(evaluations.completed_at::date, 'YYYY-MM')
          ) t1 ON true;
        "
      end
      # rubocop:enable Metrics/MethodLength, Layout/LineLength

      private_class_method :raw_sql
    end
  end
end
