# frozen_string_literal: true

module V2
  module Profile
    class ShowPresenter
      attr_reader :user

      delegate :setting, to: :user
      delegate :notifications, :unread_notifications_count, to: :notifications_presenter

      def initialize(user)
        @user = user
      end

      private

      def notifications_scope
        Notification.includes(:notifiable, :actor).where(recipient: @user)
      end

      def notifications_presenter
        @notifications_presenter ||=
          V2::Notifications::IndexPresenter.new(notifications_scope)
      end
    end
  end
end
