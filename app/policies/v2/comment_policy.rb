# frozen_string_literal: true

module V2
  class CommentPolicy < ApplicationPolicy
    def update?
      user.id == record.user_id && record.created_at > 15.minutes.ago
    end

    def destroy?
      update?
    end
  end
end
