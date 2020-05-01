# frozen_string_literal: true

module V2
  class NotifierService
    attr_reader :notifiable, :actor

    delegate :evaluator, to: :notifiable

    def initialize(notifiable:, actor:)
      @notifiable = notifiable
      @actor = actor
    end

    def notify_evaluator!(action)
      return if !evaluator&.evaluator? || evaluator == actor

      Notification.create!(
        actor: actor, recipient: evaluator, action: action, notifiable: notifiable
      )
    end

    def notify_admins!(action)
      other_admins.each do |admin|
        Notification.create!(
          actor: actor, recipient: admin, action: action, notifiable: notifiable
        )
      end
    end

    private

    def other_admins
      @other_admins ||= User.other_active_admins(actor.id)
    end
  end
end
