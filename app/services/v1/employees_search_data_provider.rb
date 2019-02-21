module V1
  class EmployeesSearchDataProvider
    attr_reader :query

    def initialize(query)
      @query = query
    end

    def call
      employees = Employee.joins(latest_evaluation: :sections)
        .includes(latest_evaluation: :sections)
        .where(latest_evaluation: { sections: { group: query_params[:group] } })
        .where('sections.skills @> ?', [{ name: query_params[:name] }].to_json)

      employees.select do |employee|
        skill = employee.latest_evaluation.sections.collect(&:skills).flatten.find { |s| s['name'] == query_params[:name] }

        if correct_value?(skill['value'])
          employee.skill = skill
        end
      end
    end

    private

    def correct_value?(skill_value)
      val = query_params[:group] == 'rating' ? query_params[:value] : query_params[:value] == 1

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
