# frozen_string_literal: true

module V2
  module Employees
    class IndexPresenter
      def initialize(scope, params: {})
        @scope = scope
        @params = params
      end

      def employees
        employees_table_query.paginated_scope
      end

      def total_count
        employees_table_query.total_count
      end

      def groups
        Employee.distinct(:group).order(:group).pluck(:group)
      end

      def evaluators
        User.all
      end

      private

      def employees_table_query
        @employees_table_query ||=
          V2::Shared::ServerSideTableQuery.new(extended_scope, params: @params)
      end

      def extended_scope
        V2::Employees::ExtendedQuery.new(@scope)
      end
    end
  end
end
