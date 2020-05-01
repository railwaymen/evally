# frozen_string_literal: true

module V2
  module Notifications
    class IndexPresenter
      def initialize(scope, size: nil)
        @scope = scope.order(created_at: :desc)
        @size = size.to_i
      end

      def notifications
        @size.positive? ? @scope.limit(@size) : @scope
      end

      def unread_notifications_count
        @scope.where(read_at: nil).count
      end
    end
  end
end
