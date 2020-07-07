# frozen_string_literal: true

module V2
  class RecruitPolicy < ApplicationPolicy
    class Scope < Scope
      def resolve
        return scope.all if %w[admin recruiter].include?(user&.role)

        user.recruits
      end
    end
  end
end
