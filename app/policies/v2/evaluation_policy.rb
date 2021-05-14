# frozen_string_literal: true

module V2
  class EvaluationPolicy < ApplicationPolicy
    class EmployableScope < Scope
      def resolve
        return scope.employable if user.admin?

        Evaluation.employable.where(evaluable_id: user.employees.ids)
      end
    end
  end
end
