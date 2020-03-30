# frozen_string_literal: true

module V2
  class RecruitPolicy < ApplicationPolicy
    class Scope < Scope
      def resolve
        return scope.all if user.admin? || user.recruiter?

        user.recruits
      end
    end
  end
end
