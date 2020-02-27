# frozen_string_literal: true

module V2
  module Views
    class EmployeesOverviewView < Blueprinter::Base
      fields :groups, :positions_chart_data, :employees_past_year_chart_data, :employees_analytics,
             :evaluations_past_year_chart_data, :evaluations_analytics
    end
  end
end
