# frozen_string_literal: true

module V2
  class EmployeesPresenter
    def initialize(scope = Employee.all)
      @scope = scope
    end

    def employees
      V2::EmployeesQuery.call(@scope)
    end

    def evaluators
      User.all
    end
  end
end
