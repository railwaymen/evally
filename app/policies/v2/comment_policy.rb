# frozen_string_literal: true

module V2
  class CommentPolicy < ApplicationPolicy
    def update?
      comment_owner? && comment_created_recently?
    end

    def destroy?
      update?
    end

    private

    def comment_owner?
      user.id == record.user_id
    end

    def comment_created_recently?
      record.created_at > 15.minutes.ago
    end
  end
end
