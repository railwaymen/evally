# frozen_string_literal: true

module V2
  class RecruitPolicy < ApplicationPolicy
    class Scope < Scope
      def resolve
        return scope.all if %w[admin recruiter].include?(user&.role)

        user.recruits
      end
    end

    def show?
      admin_or_recruiter? || assigned_evaluator?
    end

    private

    def admin_or_recruiter?
      %w[admin recruiter].include?(user&.role)
    end

    def assigned_evaluator?
      user.email_token == record.evaluator_token
    end
  end
end
