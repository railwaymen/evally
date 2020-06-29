# frozen_string_literal: true

module V2
  module Recruits
    class WebhookForm
      delegate :notify_evaluator!, :notify_recruiters!, to: :notifier_service

      def initialize(params:, user:)
        @recruit = Recruit.find_or_initialize_by(public_recruit_id: params[:public_recruit_id])
        @recruit.assign_attributes(params)

        @user = user
      end

      def save
        return unless @recruit.valid?

        if @recruit.evaluator_token_changed?
          notify_evaluator!(:assign_me)
          notify_recruiters!(:assign_evaluator)
        end

        @recruit.save
      end

      private

      def notifier_service
        @notifier_service ||= V2::NotifierService.new(notifiable: @recruit, actor: @user)
      end
    end
  end
end
