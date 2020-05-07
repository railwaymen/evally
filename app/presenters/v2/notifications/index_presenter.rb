# frozen_string_literal: true

module V2
  module Notifications
    class IndexPresenter
      def initialize(scope, params: {})
        @scope = scope.order(created_at: :desc)
        @params = params
      end

      def notifications
        pagination_service.paginate(page: @params[:page] || 1)
      end

      def total_pages
        pagination_service.pages
      end

      def unread_count
        @scope.where(read_at: nil).count
      end

      private

      def pagination_service
        @pagination_service ||=
          PaginationService.new(@scope, per_page: @params[:per_page])
      end
    end
  end
end
