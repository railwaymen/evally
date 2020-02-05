# frozen_string_literal: true

module V2
  class EmployeesOverviewPresenter
    def groups
      Employee.distinct(:group).pluck(:group)
    end

    def graph_data
      V2::EmployeesGraphQuery.new.call
    end
  end
end
