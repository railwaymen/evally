# frozen_string_literal: true

module V2
  module Comments
    class NewCommentNotifierService
      def initialize(comment, actor:)
        @comment = comment
        @actor = actor
      end

      def call
        return if @comment.persisted?

        User.active.where(users_query).map do |user|
          Notification.create(
            action: :new_comment,
            actor: @actor,
            notifiable: @comment,
            recipient: user
          )
        end
      end

      private

      def users_query
        ActiveRecord::Base.sanitize_sql(
          [
            "id != ? AND (role IN ('admin', 'recruiter') OR email_token = ?)",
            @actor.id,
            @comment.recruit.evaluator_token
          ]
        )
      end
    end
  end
end
