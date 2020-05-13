# frozen_string_literal: true

module V2
  module Sections
    class SkillsQuery
      def initialize(target: :all)
        @target = target
      end

      def call
        return [] unless verified_target?

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
          #{join_additional_tables}
          LEFT JOIN LATERAL (
            SELECT *
            FROM jsonb_array_elements(sections.skills)
          ) skills ON true
          WHERE
            #{targetable_where_clause}
            \"group\" IN ('rating', 'bool')
          ORDER BY \"group\" ASC;
        "
      end

      def join_additional_tables
        return if all?

        "
          LEFT JOIN evaluations ON
            sectionable_id = evaluations.id AND sectionable_type = 'Evaluation'
          LEFT JOIN templates ON
            sectionable_id = templates.id AND sectionable_type = 'Template'
        "
      end

      def targetable_where_clause
        return if all?

        ActiveRecord::Base.sanitize_sql(
          ['(evaluations.evaluable_type = ? OR templates.destination = ?) AND', *target_params]
        )
      end

      def target_params
        { employees: %w[Employee employees], recruits: %w[Recruit recruits] }.dig(@target)
      end

      def verified_target?
        %i[employees recruits all].include? @target
      end

      def all?
        @target == :all
      end
    end
  end
end
