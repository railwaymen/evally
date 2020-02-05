# frozen_string_literal: true

module V2
  module Views
    class EmployeesOverviewView < Blueprinter::Base
      fields :groups, :graph_data
    end
  end
end
