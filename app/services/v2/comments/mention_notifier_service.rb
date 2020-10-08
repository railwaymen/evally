# frozen_string_literal: true

require 'nokogiri'

module V2
  module Comments
    class MentionNotifierService
      def initialize(comment, actor:)
        @comment = comment
        @actor = actor
      end

      def call # rubocop:disable Metrics/MethodLength
        return if mentions.empty?

        User.active.where(users_query).map do |user|
          Notification.create(
            action: :comment_mention,
            actor: @actor,
            notifiable: @comment,
            recipient: user
          )

          NotificationMailer
            .with(comment: @comment, user: user, actor: @actor)
            .comment_mention
            .deliver_later
        end
      end

      private

      def mentions
        @mentions ||= Nokogiri::HTML.fragment(@comment.body).css('.mention')
      end

      def user_ids
        mentions.map { |el| el.attributes['data-id']&.value }.compact
      end

      def users_query
        ActiveRecord::Base.sanitize_sql(
          [
            "id IN (?) AND (role IN ('admin', 'recruiter') OR email_token = ?)",
            user_ids,
            @comment.recruit.evaluator_token
          ]
        )
      end
    end
  end
end
