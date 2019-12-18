# frozen_string_literal: true

module V1
  class EmployeesSearchDataProvider
    attr_reader :query

    def initialize(query)
      @query = query
    end

    def call
      employees.select do |employee|
        skill = employee.latest_evaluation.sections.collect(&:skills).flatten.find do |s|
          s['name'] == query_params[:name]
        end

        employee.skill = skill if correct_value?(skill['value'])
      end
    end

    private

    def employees
      @employees ||= Employee.joins(
        latest_evaluation: :sections
      ).includes(
        latest_evaluation: :sections
      ).where(
        latest_evaluation: { sections: { group: query_params[:group] } }
      ).where(
        'sections.skills @> ?', [{ name: query_params[:name] }].to_json
      )
    end

    def correct_value?(skill_value)
      val = begin
        return query_params[:value].to_i if query_params[:group] == 'rating'

        query_params[:value].to_i == 1
      end

      case query_params[:comparator]
      when 'gteq' then val &.<= skill_value
      when 'lteq' then val &.>= skill_value
      else val &.== skill_value
      end
    end

    def query_params
      query.permit(:group, :name, :comparator, :value)
    end
  end
end
