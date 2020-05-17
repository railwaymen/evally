# frozen_string_literal: true

module V2
  module Recruits
    class SearchQuery
      def initialize(scope, params:)
        @scope = scope.unscope(:order).includes(:evaluator)
        @params = params
      end

      def call
        @scope
          .joins(tables)
          .select("DISTINCT ON(recruits.id) #{fields}")
          .where("#{group_condition} AND #{skill_name_condition} AND #{skill_value_condition}")
          .order('recruits.id DESC, evaluations_join.evaluation_date DESC')
      end

      private

      def fields
        [
          'recruits.*',
          'evaluations_join.*',
          'sections_join.section_group AS skill_group',
          'skills_join.skill'
        ].join(', ')
      end

      def tables # rubocop:disable Metrics/MethodLength
        "
          INNER JOIN LATERAL (
            SELECT
              id AS evaluation_id,
              completed_at AS evaluation_date
            FROM
              evaluations
            WHERE
              evaluable_id = recruits.id AND
                evaluable_type = 'Recruit' AND
                state = 'completed'
          ) evaluations_join ON true

          INNER JOIN LATERAL(
            SELECT
              \"group\" AS section_group,
              skills AS section_skills
            FROM sections
            WHERE
              sectionable_type = 'Evaluation' AND
                sectionable_id = evaluations_join.evaluation_id
          ) sections_join ON true

          LEFT JOIN LATERAL (
            SELECT
              value AS skill
            FROM
              jsonb_array_elements(sections_join.section_skills)
          ) skills_join ON true
        "
      end

      def group_condition
        ActiveRecord::Base.sanitize_sql(
          ['sections_join.section_group = ?', @params[:group]]
        )
      end

      def skill_name_condition
        ActiveRecord::Base.sanitize_sql(
          ["(skills_join.skill->>'name')::varchar = ?", @params[:name]]
        )
      end

      def skill_value_condition
        sql = "(skills_join.skill->>'value')::#{resolve_type} #{resolve_operator} ?"

        ActiveRecord::Base.sanitize_sql([sql, @params[:value]])
      end

      def resolve_operator
        { eq: '=', gteq: '>=', lteq: '<=' }.fetch(@params[:operator]&.to_sym, '=')
      end

      def resolve_type
        { bool: 'boolean', rating: 'integer' }.fetch(@params[:group]&.to_sym, 'integer')
      end
    end
  end
end
