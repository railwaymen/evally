# frozen_string_literal: true

module V2
  class RecruitPolicy < ApplicationPolicy
    class Scope < Scope
      def resolve
        return Recruit.none if user.evaluator?

        scope.all
      end
    end
  end
end
