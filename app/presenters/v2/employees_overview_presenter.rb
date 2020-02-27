# frozen_string_literal: true

module V2
  class EmployeesOverviewPresenter
    def groups
      Employee.distinct(:group).order(:group).pluck(:group)
    end

    def positions_chart_data
      V2::EmployeesPositionsChartQuery.call
    end

    def employees_past_year_chart_data
      V2::EmployeesPastYearChartQuery.call
    end

    def analytics
      V2::EmployeesAnalyticsQuery.call
    end

    def evaluations_past_year_chart_data
      V2::EvaluationsPastYearChartQuery.call
    end
  end
end
