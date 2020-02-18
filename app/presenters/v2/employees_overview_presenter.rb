# frozen_string_literal: true

module V2
  class EmployeesOverviewPresenter
    def groups
      Employee.distinct(:group).order(:group).pluck(:group)
    end

    def positions_chart_data
      V2::PositionsChartQuery.call
    end

    def analytics
      V2::EmployeesAnalyticsQuery.call
    end
  end
end
