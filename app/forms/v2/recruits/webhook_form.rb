# frozen_string_literal: true

module V2
  module Recruits
    class WebhookForm
      delegate :notify_evaluator!, to: :notifier_service

      def initialize(params:, user:)
        @recruit = Recruit.find_or_initialize_by(public_recruit_id: params[:public_recruit_id])
        @recruit.assign_attributes(params)

        @user = user
      end

      def save
        return unless @recruit.valid?

        notify_evaluator!(:assign_me) if @recruit.evaluator_id_changed?
        @recruit.save
      end

      private

      def notifier_service
        @notifier_service ||= V2::NotifierService.new(notifiable: @recruit, actor: @user)
      end
    end
  end
end
