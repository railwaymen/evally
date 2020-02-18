# frozen_string_literal: true

module V2
  class EvaluationPolicy < ApplicationPolicy
    def show?
      return true if user.admin?

      user.id == record.employee.evaluator_id
    end
  end
end
