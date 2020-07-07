# frozen_string_literal: true

module V2
  class EvaluationPolicy < ApplicationPolicy
    class EmployableScope < Scope
      def resolve
        return scope.employable if user.admin?

        Evaluation.employable.where(evaluable_id: user.employees.ids)
      end
    end

    class RecruitableScope < Scope
      def resolve
        return scope.recruitable if %w[admin recruiter].include?(user&.role)

        Evaluation.recruitable.where(evaluable_id: user.recruits.ids)
      end
    end
  end
end
