# frozen_string_literal: true

module V2
  module Sections
    class SkillsQuery
      def self.call
        ActiveRecord::Base.connection.exec_query(raw_sql)
      end

      def self.raw_sql # rubocop:disable Metrics/MethodLength
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

      private_class_method :raw_sql
    end
  end
end
