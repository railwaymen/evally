# frozen_string_literal: true

module V2
  module Comments
    class BasicForm
      attr_reader :comment

      def initialize(comment, params:, user:)
        @comment = comment
        @user = user

        @comment.assign_attributes(params)
      end

      def save
        validate_comment!

        ActiveRecord::Base.transaction do
          new_comment_notifier.call

          @comment.save!

          mention_notifier.call
        end
      end

      private

      def validate_comment!
        return if @comment.valid?

        raise ErrorResponderService.new(:invalid_record, 422, @comment.errors.full_messages)
      end

      def mention_notifier
        V2::Comments::MentionNotifierService.new(@comment, actor: @user)
      end

      def new_comment_notifier
        V2::Comments::NewCommentNotifierService.new(@comment, actor: @user)
      end
    end
  end
end
