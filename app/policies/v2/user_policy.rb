# frozen_string_literal: true

module V2
  class UserPolicy < ApplicationPolicy
    def index?
      user.admin?
    end

    def create?
      user.admin?
    end

    def update?
      user.admin?
    end
  end
end
