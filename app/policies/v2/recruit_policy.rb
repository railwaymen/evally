# frozen_string_literal: true

module V2
  class RecruitPolicy < ApplicationPolicy
    class Scope < Scope
      def resolve
        return scope.all if user.admin? || user.recruiter?

        user.recruits
      end
    end

    def show?
      admin_or_recruiter? || assigned_evaluator?
    end

    private

    def admin_or_recruiter?
      user.admin? || user.recruiter?
    end

    def assigned_evaluator?
      user.email_token == record.evaluator_token
    end
  end
end
