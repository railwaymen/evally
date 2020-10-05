# frozen_string_literal: true

module V2
  class CommentPolicy < ApplicationPolicy
    def update?
      comment_owner? && record.created_recently? && record.created_by_human?
    end

    def destroy?
      update?
    end

    private

    def comment_owner?
      user.id == record.user_id
    end
  end
end
