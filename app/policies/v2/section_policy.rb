# frozen_string_literal: true

module V2
  class SectionPolicy < ApplicationPolicy
    class Scope < Scope
      def resolve
        return scope if !user.nil? && %w[admin recruiter].include?(user.role)

        scope.where(sensitive: false)
      end
    end
  end
end
