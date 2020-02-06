# frozen_string_literal: true

module V2
  class PositionsChartQuery
    def call
      ActiveRecord::Base.connection.exec_query(raw_sql).to_a
    end

    private

    def raw_sql # rubocop:disable Metrics/MethodLength
      "
        SELECT
          \"group\",
          position AS label,
          COUNT(position) AS value
        FROM
          employees
        GROUP BY
          \"group\",
          position
        ORDER BY \"group\" ASC;
      "
    end
  end
end
