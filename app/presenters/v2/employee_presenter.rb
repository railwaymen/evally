# frozen_string_literal: true

module V2
  class EmployeePresenter
    attr_reader :employee

    def initialize(employee)
      @employee = employee
    end

    def evaluations
      @employee.evaluations.completed.order(completed_at: :desc)
    end

    def position_changes
      @employee.position_changes.order(changed_on: :desc)
    end
  end
end
