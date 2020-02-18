# frozen_string_literal: true

module V2
  class EmployeesPresenter
    def initialize(user)
      @user = user
    end

    def employees
      V2::EmployeesQuery.call(scope)
    end

    def evaluators
      User.all
    end

    private

    def scope
      EmployeePolicy::Scope.new(@user, Employee).resolve
    end
  end
end
