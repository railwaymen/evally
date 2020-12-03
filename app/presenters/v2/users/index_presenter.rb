# frozen_string_literal: true

module V2
  module Users
    class IndexPresenter
      delegate :total_count, to: :users_table_query

      def initialize(scope, params: {})
        @scope = scope
        @params = params
      end

      def users
        users_table_query.paginated_scope
      end

      private

      def users_table_query
        @users_table_query ||=
          V2::Shared::ServerSideTableQuery.new(@scope, params: @params)
      end
    end
  end
end
