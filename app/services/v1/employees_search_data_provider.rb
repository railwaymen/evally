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
        skill = employee.latest_evaluation.sections.collect(&:skills).flatten.find{ |s| s["name"] == query_params[:name] }
        
        if correct_value?(skill["value"])
          employee.skill = skill
        end
      end
    end

    private

    def correct_value?(skill_value)
      case query_params[:comparator]
        when 'gteq' then query_params[:value] &.<= skill_value
        when 'lteq' then query_params[:value] &.>= skill_value
        else query_params[:value] &.== skill_value
      end
    end

    def query_params
      query.permit(:group, :name, :comparator, :value)
    end
  end
end
