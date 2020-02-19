# frozen_string_literal: true

module V2
  class ActivityPolicy < ApplicationPolicy
    class Scope < Scope
      def resolve
        return scope.all if user.admin?

        user.activities
      end
    end
  end
end
