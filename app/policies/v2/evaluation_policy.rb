# frozen_string_literal: true

module V2
  class EvaluationPolicy < ApplicationPolicy
    class Scope < Scope
      def resolve
        return scope.all if user.admin?

        user.evaluations
      end
    end
  end
end
