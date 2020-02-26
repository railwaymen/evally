# frozen_string_literal: true

module V2
  module Views
    class EmployeesOverviewView < Blueprinter::Base
      fields :groups, :positions_chart_data, :past_year_employees_data, :analytics
    end
  end
end
