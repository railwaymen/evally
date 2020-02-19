# frozen_string_literal: true

module V2
  class TemplatePolicy < ApplicationPolicy
    def update?
      return true if user.admin?

      user.id == record.creator_id
    end

    def destroy?
      return true if user.admin?

      user.id == record.creator_id
    end
  end
end
