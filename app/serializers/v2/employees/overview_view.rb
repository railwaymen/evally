# frozen_string_literal: true

module V2
  module Employees
    class OverviewView < Blueprinter::Base
      fields :groups, :positions_chart_data, :employees_past_year_chart_data, :employees_analytics,
             :evaluations_past_year_chart_data, :evaluations_analytics,
             :employees_by_users_chart_data
    end
  end
end
