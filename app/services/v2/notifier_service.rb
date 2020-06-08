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
      return if evaluator&.admin? || evaluator == actor

      Notification.create!(
        actor: actor, recipient: evaluator, action: action, notifiable: notifiable
      )
    end

    def notify_recruiters!(action)
      other_recruiters.each do |recruiter|
        Notification.create!(
          actor: actor, recipient: recruiter, action: action, notifiable: notifiable
        )
      end
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
      @other_admins ||= User.active_admin_other_than(actor.id)
    end

    def other_recruiters
      @other_recruiters ||= User.active_recruiter_other_than(actor.id)
    end
  end
end
