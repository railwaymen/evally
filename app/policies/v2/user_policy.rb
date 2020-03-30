# frozen_string_literal: true

module V2
  class UserPolicy < ApplicationPolicy
    def index?
      user.admin?
    end

    def active?
      %w[admin recruiter].include? user.role
    end

    def create?
      index?
    end

    def update?
      index?
    end
  end
end
