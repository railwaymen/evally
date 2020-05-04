# frozen_string_literal: true

module V2
  module Comments
    class BasicForm
      attr_reader :comment

      delegate :notify_evaluator!, to: :notifier_service

      def initialize(comment, params:, user:)
        @comment = comment
        @user = user

        @comment.assign_attributes(params)
      end

      def save
        validate_comment!

        ActiveRecord::Base.transaction do
          notify_evaluator!(:add_comment) if @comment.new_record?

          @comment.save!
        end
      end

      private

      def validate_comment!
        return if @comment.valid?

        raise ErrorResponderService.new(:invalid_record, 422, @comment.errors.full_messages)
      end

      def notifier_service
        @notifier_service ||= V2::NotifierService.new(notifiable: @comment, actor: @user)
      end
    end
  end
end
