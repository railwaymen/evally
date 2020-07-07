# frozen_string_literal: true

module V2
  class EmployeePolicy < ApplicationPolicy
    class Scope < Scope
      def resolve
        return scope.all if %w[admin recruiter].include?(user&.role)

        user.employees
      end
    end

    def create?
      %w[admin recruiter].include?(user&.role)
    end

    def archived?
      create?
    end

    def update?
      create?
    end

    def overview?
      create?
    end

    def archive?
      create?
    end

    def destroy?
      user.admin?
    end
  end
end
