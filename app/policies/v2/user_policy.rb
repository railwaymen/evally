# frozen_string_literal: true

module V2
  class UserPolicy < ApplicationPolicy
    def index?
      user.admin?
    end

    def create?
      index?
    end

    def update?
      index?
    end
  end
end
