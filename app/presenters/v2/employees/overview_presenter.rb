# frozen_string_literal: true

module V2
  module Employees
    class OverviewPresenter
      def groups
        Employee.distinct(:group).order(:group).pluck(:group)
      end

      def positions_chart_data
        V2::Employees::PositionsChartQuery.call
      end

      def employees_past_year_chart_data
        V2::Employees::PastYearChartQuery.call
      end

      def employees_analytics
        V2::Employees::AnalyticsQuery.call
      end

      def employees_by_users_chart_data
        V2::Employees::ByUsersChartQuery.call
      end

      def evaluations_past_year_chart_data
        V2::Evaluations::PastYearChartQuery.call
      end

      def evaluations_analytics
        V2::Evaluations::AnalyticsQuery.call
      end
    end
  end
end
