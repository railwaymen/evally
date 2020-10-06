# frozen_string_literal: true

module V2
  class EmailTemplatePolicy < ApplicationPolicy
    def index?
      %w[admin recruiter].include?(user&.role)
    end

    def show?
      index?
    end

    def create?
      index?
    end

    def update?
      index?
    end

    def destroy?
      index?
    end
  end
end
