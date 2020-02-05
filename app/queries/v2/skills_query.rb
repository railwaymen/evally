# frozen_string_literal: true

module V2
  class SkillsQuery
    def call
      ActiveRecord::Base.connection.exec_query(raw_sql)
    end

    private

    def raw_sql # rubocop:disable Metrics/MethodLength
      "
        SELECT
          DISTINCT \"group\",
          skills.value->>'name' AS name
        FROM
          sections
        LEFT JOIN LATERAL (
          SELECT *
          FROM jsonb_array_elements(sections.skills)
        ) skills ON true
        WHERE
          \"group\" IN ('rating', 'bool')
        ORDER BY \"group\" ASC;
      "
    end
  end
end
