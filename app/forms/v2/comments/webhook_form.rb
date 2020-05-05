# frozen_string_literal: true

module V2
  module Comments
    class WebhookForm
      delegate :notify_evaluator!, :notify_recruiters!, to: :notifier_service

      def initialize(recruit:, params:, user:)
        @comment = recruit.comments.find_or_initialize_by(change_id: params[:change_id])
        @comment.assign_attributes(
          created_by: 'bot',
          **params
        )

        @user = user
      end

      def save
        return unless @comment.valid?

        if @comment.new_record?
          notify_evaluator!(:status_change)
          notify_recruiters!(:status_change)
        end

        @comment.save
      end

      private

      def notifier_service
        @notifier_service ||= V2::NotifierService.new(notifiable: @comment, actor: @user)
      end
    end
  end
end
