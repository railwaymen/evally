# frozen_string_literal: true

module V2
  class EmployeesArchivedPresenter < EmployeesPresenter
    private

    def scope
      EmployeePolicy::Scope.new(@user, Employee).resolve.archived
    end
  end
end
